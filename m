Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 13C66DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 13:10:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B26F.02FD9946"
Subject: RE: PowerPC 460EX AD7416 Temperature Sensor
Date: Tue, 31 Mar 2009 19:10:21 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0534AB6F@SDCEXCHANGE01.ad.amcc.com>
References: <20090331125028.066613801@denx.de><20090331125451.600446749@denx.de><20090331133953.GB3044@pengutronix.de><49D21EF1.9050200@grandegger.com><20090331135629.GC3044@pengutronix.de>
	<04bf01c9b262$95478040$0109220a@deltatau.local>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Henry Bausley" <hbausley@deltatau.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B26F.02FD9946
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Did you have dts entries for IIC in device tree ? also did you have I2C =
enabled in "make menuconfig"=20
"device drivers -> i2c support -->  I2C bus support -> IBM ppc 4xx On =
chip I2C support " selected. Then you should i2c see an entry =
/proc/devices . Use that major address and create a device node "mknode =
/dev/i2c-0 c 89 0" .
=20
Write a user level program to access this device. Here is an example =
user code.
=20
----------
cat fan.c
/*  This program is an example of writing and reading an EEPROM device =
via
    SMBus on a GE Fanuc Embedded Systems, Inc. VMIVME-7809 Single Board
    Computer.
    To compile this program:
        gcc -O vmieep.c -o vmieep

    Before running this program, log in as root, then load the following
    modules using:
       /sbin/modprobe i2c-core
       /sbin/modprobe i2c-dev
       /sbin/modprobe i2c-i801
   Loading the i2c-i801 module will create /dev/i2c-0, with
   permissions =3D CRW- --- ---.  Either run the vmieep program as root,
   or change the permissions to CRW- RW- RW- as shown:
       chmod 666 /dev/i2c-0
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
//#include <linux/i2c.h>
//#include <linux/i2c-dev.h>
#include <sys/time.h>

/* The inline smbus function definitions may or may not be in i2c-dev.h,
   depending on the Linux distribution.  Comment or uncomment the =
following
   #include as necessary. */
#include "i2c-dev.h" /*  Use the file of lm_sensors  */

#define EEPROM_SIZE   256    /* Adjust for actual number of bytes in =
EEPROM */
#define EEPROM_SMBUS_ADDR  0x90 /* Do NOT change! */
int gef_eeprom_read(int fd, unsigned char start_offset, unsigned char =
*buffer,
                    unsigned short buflen);
int gef_eeprom_write(int fd, unsigned char start_offset, unsigned char =
*buffer,
                    unsigned short buflen);
void gef_msec_delay(unsigned int msecs);

int main(int argc, char *argv[])
{
    int fd;   /* File descriptor initialized with open() */
    int adapter_num =3D 0;
    int status;
    char filename[20];  /* Name of special device file */
    int i2c_addr =3D EEPROM_SMBUS_ADDR; /* SMBus address of EEPROM */
    unsigned short offset; /* Which byte to access in the EEPROM */
    unsigned char rbuffer; /* Data read from EEPROM */
    if ((argc < 3) || (argc > 4))
    {
        printf("Usage: fan read <addr> or fan write <addr> <data>\n");
        return 0;
    }
    /* Open the special device file for the SMBus */
    sprintf(filename, "/dev/i2c-%d", adapter_num);
    fd =3D open(filename, O_RDWR);
    if (fd < 0)
    {
        printf("ERROR: open(%s) failed\n", filename);
        printf("errno =3D %d, %s\n", errno, strerror(errno));
        return -1;
    }
    //printf("SUCCESS: open(%s) passed\n", filename);

    /* Specify the EEPROM as the device we want to access.
       *** IMPORTANT ***
       The address is actually in the 7 LSBs, so shift
       i2c_addr one bit to the right.*/
    status =3D ioctl(fd, I2C_SLAVE, i2c_addr>>1);
    if (status < 0)
    {
        printf("ERROR: ioctl(fd, I2C_SLAVE, 0x%02X) failed\n", =
i2c_addr);
        printf("errno =3D %d, %s\n", errno, strerror(errno));
        close(fd);
        return -1;
    }
    //printf("SUCCESS: ioctl(fd, I2C_SLAVE, 0x%02X>>1) passed\n", =
i2c_addr);

    if (strcmp(argv[1],"read") =3D=3D 0)
    {
        offset =3D atoi(argv[2]);
        gef_eeprom_read(fd, offset, &rbuffer, 1);
        printf("Offset: %d   Data: %d\n", offset, rbuffer);
    }

    if (strcmp(argv[1],"write") =3D=3D 0)
    {
        offset =3D (unsigned char)(atoi(argv[2]));
        rbuffer =3D(unsigned char)(atoi(argv[3]));
        gef_eeprom_write(fd, offset, &rbuffer, 1);
        printf("Offset: %d   Data: %d\n", offset, rbuffer);
    }

    /* Close the special device file */
    close(fd);
    return 0;
}

/////////////////////////////////////////////////////////////////////////=
/////
//
// Function name : gef_eeprom_read
//
// Description   : Read buflen bytes from the EEPROM beginning at =
start_offset
//
// Return type   : 0 for success, -1 for failure
//
// Argument      : int fd : File descriptor returned by open()
// Argument      : unsigned char start_offset : Read bytes starting at =
this
//                     offset in the EEPROM.  The sum of buflen and
//                     start_offset must not exceed the maximum size in =
bytes
//                     of the EEPROM
// Argument      : unsigned char *buffer : Where to store the bytes read
//                     from the EEPROM.  The buffer must be large enough
//                     to store buflen bytes read from the EEPROM.
// Argument      : unsigned short buflen : The size in bytes of buffer, =
or
//                     how many bytes to read from the EEPROM.  The sum =
of
//                     buflen and start_offset must not exceed the =
maximum
//                     size in bytes of the EEPROM.
//
int gef_eeprom_read(int fd, unsigned char start_offset, unsigned char =
*buffer,
                    unsigned short buflen)
{
    int offset, index;
    int data;
    for (index=3D0, offset=3Dstart_offset; index<buflen &&
        offset<EEPROM_SIZE; index++, offset++)
    {
        data =3D i2c_smbus_read_byte_data(fd, offset);
        if (data =3D=3D -1)
        {
            printf("ERROR: i2c_smbus_read_byte_data(fd, 0x%02X) =
failed\n",
                offset);
            printf("errno =3D %d, %s\n", errno, strerror(errno));
            return -1;
        }
        buffer[index] =3D (unsigned char) (data);
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////=
/////
//
// Function name : gef_eeprom_write
//
// Description   : Write buflen bytes to the EEPROM beginning at =
start_offset
//
// Return type   : 0 for success, -1 for failure
//
// Argument      : int fd : File descriptor returned by open()
// Argument      : unsigned char start_offset : Write bytes starting at =
this
//                     offset in the EEPROM.  The sum of buflen and
//                     start_offset must not exceed the maximum size in =
bytes
//                     of the EEPROM
// Argument      : unsigned char *buffer : Where to get the bytes to =
write
//                     to the EEPROM.
// Argument      : unsigned short buflen : The size in bytes of buffer.
//                     The sum of buflen and start_offset must not =
exceed the
//                     maximum size in bytes of the EEPROM.
//
int gef_eeprom_write(int fd, unsigned char start_offset, unsigned char =
*buffer,
                    unsigned short buflen)
{
    int offset, index;
    int status;
    for (index=3D0, offset=3Dstart_offset; index<buflen &&
        offset<EEPROM_SIZE; index++, offset++)
    {
        status =3D i2c_smbus_write_byte_data(fd, offset, buffer[index]);
        if (status < 0)
        {
            printf("ERROR: i2c_smbus_write_byte_data(fd, 0x%02X, 0x%02X) =
failed\n",
                offset, buffer[index]);
            printf("errno =3D %d, %s\n", errno, strerror(errno));
            return -1;
        }
        /* Delay while the byte write completes */
        gef_msec_delay(10);
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////=
/////
//
// Function name : gef_msec_delay
//
// Description   : Delay for a number of milliseconds before returning
//
// Return type   : void
//
// Argument      : unsigned int msecs : The number of milliseconds to =
delay
//
void gef_msec_delay(unsigned int msecs)
{
    struct timeval s_current, s_start;
    struct timezone tz;
    unsigned int current, start;

    /* Get initial time */
    gettimeofday(&s_start, &tz);
    start =3D s_start.tv_sec*1000000 + s_start.tv_usec;
    /* Loop until msecs time have elapsed */
    do
    {
        gettimeofday(&s_current, &tz);
        current =3D s_current.tv_sec*1000000 + s_current.tv_usec;
    } while ((current-start) < (msecs*1000));
}

-------------

________________________________

From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of =
Henry Bausley
Sent: Tue 3/31/2009 5:41 PM
To: linuxppc-dev@ozlabs.org
Subject: PowerPC 460EX AD7416 Temperature Sensor



Does anyone know if the I2C temperature sensor is functioning on the =
AMCC
460EX?
When I do a cat /proc/ad7416 I get the following crash.

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc02cbe28
Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
NIP: c02cbe28 LR: c023cec8 CTR: c023d314
REGS: ef107d90 TRAP: 0300   Not tainted  (2.6.28.7)
MSR: 00029000 <EE,ME>  CR: 88000444  XER: 00000000
DEAR: 00000000, ESR: 00000000
TASK =3D ef8590c0[2611] 'cat' THREAD: ef106000
GPR00: 00000000 ef107e40 ef8590c0 00000000 ef107e9c 00000000 00000c00
ef107e98
GPR08: 00000000 c0330000 ffffffff c0330000 48000448 1001cb7c 100042bc
100df49c
GPR16: 00000002 00000400 c032f014 c032efe4 ef107e9c ef107e98 bfffffff
efb43a00
GPR24: ef61d000 00000000 ef107f20 ef107e98 00000c00 c0400000 00001000
efb43a00
NIP [c02cbe28] mutex_lock+0x0/0x1c
LR [c023cec8] ad7416_read_temp+0x24/0x80
Call Trace:
[ef107e40] [00000400] 0x400 (unreliable)
[ef107e70] [c023d334] i2c_ad7416_read_proc+0x20/0x70
[ef107e90] [c00e8018] proc_file_read+0x108/0x334
[ef107ee0] [c00e2d3c] proc_reg_read+0x4c/0x70
[ef107ef0] [c00a54e8] vfs_read+0xb4/0x16c
[ef107f10] [c00a58e0] sys_read+0x4c/0x90
[ef107f40] [c000ea88] ret_from_syscall+0x0/0x3c
Instruction dump:
90010014 38000001 90030000 85230004 7f891800 419e000c 80690008 4bd50779
80010014 38210010 7c0803a6 4e800020 <7c001828> 3000ffff 7c00192d =
40a2fff4
---[ end trace 774db769c3754abe ]---



**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C9B26F.02FD9946
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>PowerPC 460EX AD7416 Temperature =
Sensor</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16788" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText836 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Did you have =
dts entries for IIC in device tree ? also did you have I2C enabled in =
"make menuconfig" </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>"device drivers -&gt; i2c =
support --&gt;&nbsp; I2C bus support -&gt; IBM ppc 4xx On chip I2C =
support " selected. Then you should i2c see an entry /proc/devices . Use =
that major address and create a device node "mknode /dev/i2c-0 c 89 0" =
.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Write a user level program to =
access this device. Here is an example user code.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>----------</FONT></DIV>=0A=
<DIV dir=3Dltr>cat fan.c<BR>/*&nbsp; This program is an example of =
writing and reading an EEPROM device via<BR>&nbsp;&nbsp;&nbsp; SMBus on =
a GE Fanuc Embedded Systems, Inc. VMIVME-7809 Single =
Board<BR>&nbsp;&nbsp;&nbsp; Computer.</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; To compile this program:</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gcc -O =
vmieep.c -o vmieep</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; Before running this program, log =
in as root, then load the following<BR>&nbsp;&nbsp;&nbsp; modules =
using:</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/modprobe =
i2c-core<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/modprobe =
i2c-dev<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/modprobe =
i2c-i801</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp; Loading the i2c-i801 module will create =
/dev/i2c-0, with<BR>&nbsp;&nbsp; permissions =3D CRW- --- ---.&nbsp; =
Either run the vmieep program as root,<BR>&nbsp;&nbsp; or change the =
permissions to CRW- RW- RW- as shown:</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chmod 666 =
/dev/i2c-0</DIV>=0A=
<DIV dir=3Dltr>*/</DIV>=0A=
<DIV dir=3Dltr><BR>#include &lt;stdio.h&gt;<BR>#include =
&lt;string.h&gt;<BR>#include &lt;stdlib.h&gt;<BR>#include =
&lt;errno.h&gt;<BR>#include &lt;fcntl.h&gt;<BR>//#include =
&lt;linux/i2c.h&gt;<BR>//#include &lt;linux/i2c-dev.h&gt;<BR>#include =
&lt;sys/time.h&gt;</DIV>=0A=
<DIV dir=3Dltr><BR>/* The inline smbus function definitions may or may =
not be in i2c-dev.h,<BR>&nbsp;&nbsp; depending on the Linux =
distribution.&nbsp; Comment or uncomment the following<BR>&nbsp;&nbsp; =
#include as necessary. */<BR>#include "i2c-dev.h" /*&nbsp; Use the file =
of lm_sensors&nbsp; */</DIV>=0A=
<DIV dir=3Dltr><BR>#define EEPROM_SIZE&nbsp;&nbsp; 256&nbsp;&nbsp;&nbsp; =
/* Adjust for actual number of bytes in EEPROM */<BR>#define =
EEPROM_SMBUS_ADDR&nbsp; 0x90 /* Do NOT change! */</DIV>=0A=
<DIV dir=3Dltr>int gef_eeprom_read(int fd, unsigned char start_offset, =
unsigned char =
*buffer,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short =
buflen);<BR>int gef_eeprom_write(int fd, unsigned char start_offset, =
unsigned char =
*buffer,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short =
buflen);<BR>void gef_msec_delay(unsigned int msecs);</DIV>=0A=
<DIV dir=3Dltr><BR>int main(int argc, char =
*argv[])<BR>{<BR>&nbsp;&nbsp;&nbsp; int fd;&nbsp;&nbsp; /* File =
descriptor initialized with open() */<BR>&nbsp;&nbsp;&nbsp; int =
adapter_num =3D 0;<BR>&nbsp;&nbsp;&nbsp; int =
status;<BR>&nbsp;&nbsp;&nbsp; char filename[20];&nbsp; /* Name of =
special device file */<BR>&nbsp;&nbsp;&nbsp; int i2c_addr =3D =
EEPROM_SMBUS_ADDR; /* SMBus address of EEPROM */<BR>&nbsp;&nbsp;&nbsp; =
unsigned short offset; /* Which byte to access in the EEPROM =
*/<BR>&nbsp;&nbsp;&nbsp; unsigned char rbuffer; /* Data read from EEPROM =
*/</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; if ((argc &lt; 3) || (argc &gt; =
4))<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Usage: fan read =
&lt;addr&gt; or fan write &lt;addr&gt; =
&lt;data&gt;\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; /* Open the special =
device file for the SMBus */<BR>&nbsp;&nbsp;&nbsp; sprintf(filename, =
"/dev/i2c-%d", adapter_num);<BR>&nbsp;&nbsp;&nbsp; fd =3D open(filename, =
O_RDWR);<BR>&nbsp;&nbsp;&nbsp; if (fd &lt; 0)<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("ERROR: open(%s) =
failed\n", filename);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("errno =3D %d, %s\n", errno, =
strerror(errno));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-1;<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; //printf("SUCCESS: =
open(%s) passed\n", filename);</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; /* Specify the EEPROM as the =
device we want to access.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *** =
IMPORTANT ***<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The address is =
actually in the 7 LSBs, so shift<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2c_addr one bit to the right.*/<BR>&nbsp;&nbsp;&nbsp; status =3D =
ioctl(fd, I2C_SLAVE, i2c_addr&gt;&gt;1);<BR>&nbsp;&nbsp;&nbsp; if =
(status &lt; 0)<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("ERROR: ioctl(fd, =
I2C_SLAVE, 0x%02X) failed\n", =
i2c_addr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("errno =
=3D %d, %s\n", errno, =
strerror(errno));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
close(fd);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-1;<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; //printf("SUCCESS: =
ioctl(fd, I2C_SLAVE, 0x%02X&gt;&gt;1) passed\n", i2c_addr);</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; if (strcmp(argv[1],"read") =3D=3D =
0)<BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
offset =3D atoi(argv[2]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
gef_eeprom_read(fd, offset, &amp;rbuffer, =
1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Offset: =
%d&nbsp;&nbsp; Data: %d\n", offset, rbuffer);<BR>&nbsp;&nbsp;&nbsp; =
}</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; if (strcmp(argv[1],"write") =3D=3D =
0)<BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
offset =3D (unsigned =
char)(atoi(argv[2]));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rbuffer =3D(unsigned =
char)(atoi(argv[3]));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
gef_eeprom_write(fd, offset, &amp;rbuffer, =
1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Offset: =
%d&nbsp;&nbsp; Data: %d\n", offset, rbuffer);<BR>&nbsp;&nbsp;&nbsp; =
}</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; /* Close the special device file =
*/<BR>&nbsp;&nbsp;&nbsp; close(fd);</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; return 0;<BR>}</DIV>=0A=
<DIV =
dir=3Dltr><BR>///////////////////////////////////////////////////////////=
///////////////////<BR>//<BR>// Function name : =
gef_eeprom_read<BR>//<BR>// Description&nbsp;&nbsp; : Read buflen bytes =
from the EEPROM beginning at start_offset<BR>//<BR>// Return =
type&nbsp;&nbsp; : 0 for success, -1 for failure<BR>//<BR>// =
Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : int fd : File descriptor =
returned by open()<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
unsigned char start_offset : Read bytes starting at =
this<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset in the =
EEPROM.&nbsp; The sum of buflen =
and<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_offset =
must not exceed the maximum size in =
bytes<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of the =
EEPROM<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : unsigned char =
*buffer : Where to store the bytes =
read<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from the =
EEPROM.&nbsp; The buffer must be large =
enough<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to store =
buflen bytes read from the EEPROM.<BR>// =
Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : unsigned short buflen : The =
size in bytes of buffer, =
or<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; how many bytes =
to read from the EEPROM.&nbsp; The sum =
of<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buflen and =
start_offset must not exceed the =
maximum<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size in =
bytes of the EEPROM.<BR>//</DIV>=0A=
<DIV dir=3Dltr>int gef_eeprom_read(int fd, unsigned char start_offset, =
unsigned char =
*buffer,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short =
buflen)<BR>{<BR>&nbsp;&nbsp;&nbsp; int offset, =
index;<BR>&nbsp;&nbsp;&nbsp; int data;</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; for (index=3D0, offset=3Dstart_offset; =
index&lt;buflen &amp;&amp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
offset&lt;EEPROM_SIZE; index++, offset++)<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
i2c_smbus_read_byte_data(fd, =
offset);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data =3D=3D =
-1)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("ERROR: i2c_smbus_read_byte_data(fd, 0x%02X) =
failed\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
offset);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; printf("errno =3D %d, %s\n", errno, =
strerror(errno));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -1;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index] =3D =
(unsigned char) (data);<BR>&nbsp;&nbsp;&nbsp; }</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; return 0;<BR>}</DIV>=0A=
<DIV =
dir=3Dltr><BR>///////////////////////////////////////////////////////////=
///////////////////<BR>//<BR>// Function name : =
gef_eeprom_write<BR>//<BR>// Description&nbsp;&nbsp; : Write buflen =
bytes to the EEPROM beginning at start_offset<BR>//<BR>// Return =
type&nbsp;&nbsp; : 0 for success, -1 for failure<BR>//<BR>// =
Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : int fd : File descriptor =
returned by open()<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
unsigned char start_offset : Write bytes starting at =
this<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset in the =
EEPROM.&nbsp; The sum of buflen =
and<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_offset =
must not exceed the maximum size in =
bytes<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of the =
EEPROM<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : unsigned char =
*buffer : Where to get the bytes to =
write<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to the =
EEPROM.<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : unsigned short =
buflen : The size in bytes of =
buffer.<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The sum of =
buflen and start_offset must not exceed =
the<BR>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maximum size in =
bytes of the EEPROM.<BR>//</DIV>=0A=
<DIV dir=3Dltr>int gef_eeprom_write(int fd, unsigned char start_offset, =
unsigned char =
*buffer,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short =
buflen)<BR>{<BR>&nbsp;&nbsp;&nbsp; int offset, =
index;<BR>&nbsp;&nbsp;&nbsp; int status;</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; for (index=3D0, offset=3Dstart_offset; =
index&lt;buflen &amp;&amp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
offset&lt;EEPROM_SIZE; index++, offset++)<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
i2c_smbus_write_byte_data(fd, offset, =
buffer[index]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status =
&lt; 0)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("ERROR: i2c_smbus_write_byte_data(fd, 0x%02X, 0x%02X) =
failed\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset, =
buffer[index]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; printf("errno =3D %d, %s\n", errno, =
strerror(errno));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -1;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Delay while =
the byte write completes =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
gef_msec_delay(10);<BR>&nbsp;&nbsp;&nbsp; }</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; return 0;<BR>}</DIV>=0A=
<DIV =
dir=3Dltr><BR>///////////////////////////////////////////////////////////=
///////////////////<BR>//<BR>// Function name : =
gef_msec_delay<BR>//<BR>// Description&nbsp;&nbsp; : Delay for a number =
of milliseconds before returning<BR>//<BR>// Return type&nbsp;&nbsp; : =
void<BR>//<BR>// Argument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : unsigned int =
msecs : The number of milliseconds to delay<BR>//</DIV>=0A=
<DIV dir=3Dltr>void gef_msec_delay(unsigned int =
msecs)<BR>{<BR>&nbsp;&nbsp;&nbsp; struct timeval s_current, =
s_start;<BR>&nbsp;&nbsp;&nbsp; struct timezone tz;<BR>&nbsp;&nbsp;&nbsp; =
unsigned int current, start;</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;&nbsp;&nbsp; /* Get initial time =
*/<BR>&nbsp;&nbsp;&nbsp; gettimeofday(&amp;s_start, =
&amp;tz);<BR>&nbsp;&nbsp;&nbsp; start =3D s_start.tv_sec*1000000 + =
s_start.tv_usec;</DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp; /* Loop until msecs time have elapsed =
*/<BR>&nbsp;&nbsp;&nbsp; do<BR>&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
gettimeofday(&amp;s_current, =
&amp;tz);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current =3D =
s_current.tv_sec*1000000 + s_current.tv_usec;<BR>&nbsp;&nbsp;&nbsp; } =
while ((current-start) &lt; (msecs*1000));<BR>}</DIV>=0A=
<DIV dir=3Dltr><BR>-------------</DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of Henry =
Bausley<BR><B>Sent:</B> Tue 3/31/2009 5:41 PM<BR><B>To:</B> =
linuxppc-dev@ozlabs.org<BR><B>Subject:</B> PowerPC 460EX AD7416 =
Temperature Sensor<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Does anyone know if the I2C temperature sensor is =
functioning on the AMCC<BR>460EX?<BR>When I do a cat /proc/ad7416 I get =
the following crash.<BR><BR>Unable to handle kernel paging request for =
data at address 0x00000000<BR>Faulting instruction address: =
0xc02cbe28<BR>Oops: Kernel access of bad area, sig: 11 [#1]<BR>PowerPC =
44x Platform<BR>NIP: c02cbe28 LR: c023cec8 CTR: c023d314<BR>REGS: =
ef107d90 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.28.7)<BR>MSR: =
00029000 &lt;EE,ME&gt;&nbsp; CR: 88000444&nbsp; XER: 00000000<BR>DEAR: =
00000000, ESR: 00000000<BR>TASK =3D ef8590c0[2611] 'cat' THREAD: =
ef106000<BR>GPR00: 00000000 ef107e40 ef8590c0 00000000 ef107e9c 00000000 =
00000c00<BR>ef107e98<BR>GPR08: 00000000 c0330000 ffffffff c0330000 =
48000448 1001cb7c 100042bc<BR>100df49c<BR>GPR16: 00000002 00000400 =
c032f014 c032efe4 ef107e9c ef107e98 bfffffff<BR>efb43a00<BR>GPR24: =
ef61d000 00000000 ef107f20 ef107e98 00000c00 c0400000 =
00001000<BR>efb43a00<BR>NIP [c02cbe28] mutex_lock+0x0/0x1c<BR>LR =
[c023cec8] ad7416_read_temp+0x24/0x80<BR>Call Trace:<BR>[ef107e40] =
[00000400] 0x400 (unreliable)<BR>[ef107e70] [c023d334] =
i2c_ad7416_read_proc+0x20/0x70<BR>[ef107e90] [c00e8018] =
proc_file_read+0x108/0x334<BR>[ef107ee0] [c00e2d3c] =
proc_reg_read+0x4c/0x70<BR>[ef107ef0] [c00a54e8] =
vfs_read+0xb4/0x16c<BR>[ef107f10] [c00a58e0] =
sys_read+0x4c/0x90<BR>[ef107f40] [c000ea88] =
ret_from_syscall+0x0/0x3c<BR>Instruction dump:<BR>90010014 38000001 =
90030000 85230004 7f891800 419e000c 80690008 4bd50779<BR>80010014 =
38210010 7c0803a6 4e800020 &lt;7c001828&gt; 3000ffff 7c00192d =
40a2fff4<BR>---[ end trace 774db769c3754abe =
]---<BR><BR><BR><BR>*****************************************************=
*****<BR>Outbound scan for Spam or Virus by Barracuda at Delta =
Tau<BR>**********************************************************<BR>____=
___________________________________________<BR>Linuxppc-dev mailing =
list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C9B26F.02FD9946--
