Message-ID: <40E49100.2060501@246tNt.com>
Date: Fri, 02 Jul 2004 00:32:32 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: mcclintock@freescale.com,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Matthew McClintock <mcclintock@motorola.com>
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
References: <1088705955.28598.168.camel@localhost>	 <1088693987.7555.60.camel@matthew-laptop> <1088717127.28598.197.camel@localhost>
In-Reply-To: <1088717127.28598.197.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------030700040208000902080203"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030700040208000902080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Cox wrote:

>It seems that the MPC107 is happy with 8 bit accesses to the registers,
>so here's another version of the patch. This also changes the time
>calculations to use time_after().
>
>
The MPC5200 seems happy too ;) There is a eeprom on the board and it's
detected and I can access it. If I find a soldering iron, I'll hook up
another I2C device to test other devices.

Some gotchas though :

 - The FDR computation is completly different. Here is the code I
attached the code I used in my I2C driver. Basically, it takes as
argument the desired I2C clock rate ( was a module parameter ) and the
internal bus frequency and then compute the FDR.
 - During the scan, the first bus is scanned without devices and the
error when debug is active is I2C_MAL. From the moment the eeprom is
detected, the error code become I2C_NORXACK for the address wihout
device. Included dmesg

drivers/i2c/busses/i2c-mpc.c: Doing write 0 bytes to 0x57 - 1 of 1 messages
drivers/i2c/busses/i2c-mpc.c: I2C: MAL
i2c_adapter i2c-1: found normal i2c_range entry for adapter 1, addr 0050
i2c_adapter i2c-1: master_xfer: with 1 msgs.
drivers/i2c/busses/i2c-mpc.c: Doing write 0 bytes to 0x50 - 1 of 1 messages
i2c_adapter i2c-1: master_xfer: with 1 msgs.
drivers/i2c/busses/i2c-mpc.c: Doing write 0 bytes to 0x50 - 1 of 1 messages
i2c_adapter i2c-1: client [eeprom] registered to adapter
registering 1-0050
i2c_adapter i2c-1: found normal i2c_range entry for adapter 1, addr 0051
i2c_adapter i2c-1: master_xfer: with 1 msgs.
drivers/i2c/busses/i2c-mpc.c: Doing write 0 bytes to 0x51 - 1 of 1 messages
drivers/i2c/busses/i2c-mpc.c: I2C: No RXAK
i2c_adapter i2c-1: found normal i2c_range entry for adapter 1, addr 0052
i2c_adapter i2c-1: master_xfer: with 1 msgs.

 - The interrupt bit. BTW, on what event should the interrupt be fired ?
(I did my test without any interrupts )

>This still leaves the interrupt handling register of the MPC5200
>unsolved. I suggest introducing another flag for the MPC5200, and adding
>a small piece of extra setup code.
>
>
Yes, something like FS_I2C_IS_MPC52xx


Another remark : The register setup are done at every _start. Couldn't
they be done once for all during init ( just after the probe, call a
init_hardware functions ).



Sylvain Munaut

--------------030700040208000902080203
Content-Type: text/x-csrc;
 name="fdr_mpc5200.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fdr_mpc5200.c"

static int
mpc52xx_i2c_get_best_fdr(int ipb_freq, int i2c_speed)
{
	/* Consts */
	const struct { int scl2tap; int tap2tap; } x2taps[] = {
		{   4,   1 },
		{   4,   2 },
		{   6,   4 },
		{   6,   8 },
		{  14,  16 },
		{  30,  32 },
		{  62,  64 },
		{ 126, 128 },
	};
	const int scl_taps[] = { 9, 10, 12, 15, 5, 6, 7, 8 };

	int best_i, best_j, i, j;
	int scl;
	int best_diff = 0x7fffffff, diff;
	int fdr;

	for ( i=7 ; i>=0 ; i-- ) {
		for ( j=0 ; j<8 ; j++ ) {
			scl = 2 * (x2taps[i].scl2tap + ((scl_taps[j] - 1) * x2taps[i].tap2tap) + 2);
			/* We only want frequency BELOW or EQUAL to */
			/* the target frequency */
			diff = i2c_speed * scl - ipb_freq;
			if ( (diff > 0) && (diff < best_diff) ) {
				best_diff = diff;
				best_i = i;
				best_j = j;
			}
		}
	}

	fdr = ((best_i << 2) | (best_j & 0x03) | ((best_j & 0x04) << 5)) & 0x3f;
	return fdr;
}

--------------030700040208000902080203--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
