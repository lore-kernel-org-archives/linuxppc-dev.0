Message-ID: <3AB76E8F.CE71FD0B@esd-electronics.com>
Date: Tue, 20 Mar 2001 15:51:59 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
CC: Frank Rowand <frank_rowand@mvista.com>
Subject: i2c driver problem
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a little problem with the Linux i2c driver (IBM405CR CPU,custom
board, internal i2c port with MontaVista's hardhat Linux, kernel 2.4.0).
Here is my test programm. It tries to access a serial EEPROM (cytalyst
24WC08) with i2c address 0x1010000rw.

#define I2C_EEPROM_ADDR 0xa0
#define I2C_DEVICE      "/dev/i2c-0"

int i2c_test()
{
  int i;
  int result;
  int addr;
  char buffer[I2C_EEPROM_SIZE];

  /* open i2c device */
  if ((fd_i2c = open(I2C_DEVICE,O_RDWR)) < 0)
    {
      perror("open i2c device: ");
      return -1;
    }

  /* set i2c slave address (0xa0 for a catalyst serial eeprom 24wc08,
first bank) */
  addr = I2C_EEPROM_ADDR >> 1;

  if (ioctl(fd_i2c,I2C_SLAVE,addr) < 0)
    {
      perror("ioctl I2C_SLAVE: ");
      return -1;
    }

  /* write address pointer in eeprom (bank 0, first byte) */
  buffer[0]=0;
  result = write(fd_i2c,buffer,1); /* write addresse pointer */
  printf("address pointer set to 0, result=%d\n",result);

  /* read the first 64 bytes from eeprom */
  result = read(fd_i2c,buffer,64);
  printf("read %d out of 64 bytes\n",result);

  for(i=1; i<=64; i++)
    {
      printf("%02x ",buffer[i-1]);
      if ((i % 32)==0)
	printf("\n");
    }

  close(fd_i2c);
  return 0;
}

This program outputs that a NACK is received during the transfer of the
i2c address.
Did I misunderstood the i2c driver interface ? I can access the EEPROM
from within my bootloader (ppcboot) with no problems.

My proc/bus/i2c looks ok !

Is this a bug in the i2c driver ?

Matthias
--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straße 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
