Message-ID: <B25E2E5A003CD311B61E00902778AF2A039C3797@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Reliable way of reseting 8xx
Date: Fri, 8 Feb 2002 08:41:35 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

On my 8xx board standard reboot doesn't seem to reboot the system. It resets
the processor but it seems that
8xx is entering debug mode. So I wrote following function which I thought
could fix the problem. It
"seems" to be working, can someone verify if my 8xx reset function below is
correct?

My understanding is the following I need to clear bit CHSTPE, enable the
checkstop reset and cause
a intentional machine check...



{
	int nr = 0;
	ulong msr, der, addr;
	/* Ref. Page 15-31, Page 37-46 */

#define SET_REGISTER( str, val ) \
({ unsigned long __value = (val); \
  asm volatile( str : : "r" (__value)); \
    __value; })

#define GET_REGISTER( str ) \
({ unsigned long __value; \
	asm volatile( str : "=r" (__value) : ); \
	__value; })
#define  SET_DER(val)    SET_REGISTER( "mtspr 149,%0", val )
#define  GET_DER()       GET_REGISTER( "mfspr %0,149" )

	der = GET_DER();
	SET_DER(der & ~0x20000000 );	/* CLEAR THE CHSTPE bit in DER
register */
	immap->im_clkrst.car_plprcr |= 0x00000080; /* Checkstop Reset enable
*/
	/* Interrupts and MMU off */
	__asm__ volatile ("mtspr    81, 0");
	__asm__	volatile ("mfmsr    %0" : "=r"(msr));
	msr &= ~0x1030;
	__asm__ volatile ("mtmsr    %0" :: "r"(msr) );

	/*
	* Trying to execute the next instruction at a non-existing address
	* should cause a machine check, resulting in reset??
	*/
	addr = ~0x0;
	((void (*)(void ))addr)();
	return nr;
}



/Subodh Nijsure
Software Manager - Network Media Routers
SkyStream Networks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
