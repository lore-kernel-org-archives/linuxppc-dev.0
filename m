Return-Path: <kkboyanov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 28168DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 01:14:59 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1509843ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Mar 2007 08:14:56 -0700 (PDT)
Message-ID: <929bf310703260814q18957942s218d56bed8fb4009@mail.gmail.com>
Date: Mon, 26 Mar 2007 17:14:54 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Reading and writing from/to VME device
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_257142_19717382.1174922094648"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_257142_19717382.1174922094648
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

I'm using the MVME6100 board with the Motorola driver for linux v3.5 (kernel
2.6.15). I try to access the CSR registers of an ADC board, in order to
configure it as to be able to access its memory, on the VME bus using one of
the outbound windows defined by the driver. As I am new to the whole VME
stuff, I'm getting into trouble to find out when I'm actually reading
something on the VME, i.e. which addresses respond.
I'm trying the following schema (source code @ EOM):

1. open() and ioctl() one of the /dev/vme_m* devices, which I assume is
corresponding to an outbound window (at least I try to configure it as one),

2. then mmap() a memory area to hold the contents of the /dev/vme_m* device
file
3. and finally doing incrementation of the pointer returned by mmap() and
dereferencing it in the hope that I'll read something, which in most cases
is 0xFF

In fact my code is very similar to test code that comes with the driver and
also with a sample code I found in this thread ->
http://ozlabs.org/pipermail/linuxppc-dev/1999-May/001906.html
I've tried to do a read() on the opened /dev/vme_m* device but I only
succeed in reading 0 bytes, and when I try to read in chunks from the VME
bus i get errno 22 on reads like read(fd, buffer, 1024) for example.

I don't know if my strategy is correct in the first place but that's what I
came up with.
When I try to run one of the test applications that came with the driver
(the "testout" one) I get an errno = 29 (Illegal seek?! ) on the read()
operations.
So my question is whether I make the right steps in reading an address on
the VME bus. I know I'm missing something, so I'll be glad to get some
directions as to how to be sure whether I'm reading something from the VME
bus and where I'm able to write.

Best regards,
Konstantin
________________________________

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include "vmedrv.h"

int main(int argc, char* argv[])
{
    vmeOutWindowCfg_t outWinCfg;
    vmeOutWindowCfg_t outWinGet;

    int fdOut, status, i, j;
    unsigned int  n;
    u_char *rdPtr, *getPtr;

    if(getMyVmeInfo()){
      printf("getMyVmeInfo failed.\n");
      exit (1);
    }

    fdOut = open("/dev/vme_m0", O_RDWR);
    perror("open");
    if(fdOut < 0){
      printf("Opening /dev/vme_m0 failed. Errno = %d\n", errno);
    }

    memset(&outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));
    perror("memset");

    outWinCfgADC.windowNbr          = 0;
    outWinCfgADC.windowEnable     = 1;
    outWinCfgADC.wrPostEnable      = 0;
    outWinCfgADC.userAccessType  = VME_SUPER;
    outWinCfgADC.dataAccessType  = VME_DATA;
    outWinCfgADC.windowSizeL       = 0x200000;
    outWinCfgADC.xferProtocol         = VME_SCT;
    outWinCfgADC.addrSpace           = VME_A24;
    outWinCfgADC.maxDataWidth     = VME_D16;

    status = ioctl(fdOut, VME_IOCTL_SET_OUTBOUND, &outWinCfgADC);
    perror("ioctl");
    if(status < 0){
        printf("*** ioctl set on outWinCfgADC failed. Errno = %d\n", errno);
        exit (1);
    }
    memset(&outWinGetADC, 0, sizeof(vmeOutWindowCfg_t));
    outWinGetADC.windowNbr = 0;

    status = ioctl(fdOut, VME_IOCTL_GET_OUTBOUND, &outWinGetADC);
    perror("ioctl");
    if(status < 0){
        printf("*** ioctl get on outWinGetADC failed. Errno = %d\n", errno);
        exit (1);
    }

    /*
     * Check wheather the get and set configurations are the same
     */

    getPtr = (u_char *) mmap(0, outWinCfgADC.windowSizeL,
PROT_READ|PROT_WRITE, MAP_SHARED, fdOut, 0);
    perror("mmap");
    printf("# Start of outbound win in virtual address space of the process:
%p\n", getPtr);

    rdPtr = getPtr;

    for(i=0;i<0x100;i++){
       printf("# Read at address %x = %x\n", rdPtr, *rdPtr);
       rdPtr++;
    }

    status = close(fdOut);
    if(status != 0){
        printf("*** close() failed. Errno = %d\n", errno);
        exit (1);
    }

    return 0;
}

__________________________________
Part of the output:

mmap: Illegal seek
# Start of outbound win in virtual address space of the process: 0x30029000
# Read at address 30029000 = ff
# Read at address 30029001 = ff
# Read at address 30029002 = ff
# Read at address 30029003 = ff
# Read at address 30029004 = ff
# Read at address 30029005 = ff
# Read at address 30029006 = ff
# Read at address 30029007 = ff
# Read at address 30029008 = ff
# Read at address 30029009 = ff
# Read at address 3002900a = ff
# Read at address 3002900b = ff

and etc.

------=_Part_257142_19717382.1174922094648
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,<br><br>I&#39;m using the MVME6100 board with the Motorola driver for linux v3.5 (kernel 2.6.15). I try to access the CSR registers of an ADC board, in order to configure it as to be able to access its memory, on the VME bus using one of the outbound windows defined by the driver. As I am new to the whole VME stuff, I&#39;m getting into trouble to find out when I&#39;m actually reading something on the VME, 
i.e. which addresses respond.<br>I&#39;m trying the following schema (source code @ EOM):<br><br>1. open() and ioctl() one of the /dev/vme_m* devices, which I assume is corresponding to an outbound window (at least I try to configure it as one), 
<br>2. then mmap() a memory area to hold the contents of the /dev/vme_m* device file<br>3. and finally doing incrementation of the pointer returned by mmap() and dereferencing it in the hope that I&#39;ll read something, which in most cases is 0xFF
<br><br>In fact my code is very similar to test code that comes with the driver and also with a sample code I found in this thread -&gt;<a href="http://ozlabs.org/pipermail/linuxppc-dev/1999-May/001906.html">http://ozlabs.org/pipermail/linuxppc-dev/1999-May/001906.html
</a><br>I&#39;ve tried to do a read() on the opened /dev/vme_m* device but I only succeed in reading 0 bytes, and when I try to read in chunks from the VME bus i get errno 22 on reads like read(fd, buffer, 1024) for example.
<br><br>I don&#39;t know if my strategy is correct in the first place but that&#39;s what I came up with. <br>When I try to run one of the test applications that came with the driver (the &quot;testout&quot; one) I get an errno = 29 (Illegal seek?! ) on the read() operations.
<br>So my question is whether I make the right steps in reading an address on the VME bus. I know I&#39;m missing something, so I&#39;ll be glad to get some directions as to how to be sure whether I&#39;m reading something from the VME bus and where I&#39;m able to write. 
<br><br>Best regards,<br>Konstantin<br>________________________________<br><br>#include &lt;stdio.h&gt; <br>#include &lt;string.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br>#include &lt;unistd.h&gt;
<br>#include &quot;vmedrv.h&quot;<br><br>int main(int argc, char* argv[])<br>{<br>&nbsp;&nbsp;&nbsp; vmeOutWindowCfg_t outWinCfg;<br>&nbsp;&nbsp;&nbsp; vmeOutWindowCfg_t outWinGet;<br><br>&nbsp;&nbsp;&nbsp; int fdOut, status, i, j;<br>&nbsp;&nbsp;&nbsp; unsigned int&nbsp; n;<br>&nbsp;&nbsp;&nbsp; u_char *rdPtr, *getPtr;
<br><br>&nbsp;&nbsp;&nbsp; if(getMyVmeInfo()){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;getMyVmeInfo failed.\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; fdOut = open(&quot;/dev/vme_m0&quot;, O_RDWR);<br>&nbsp;&nbsp;&nbsp; perror(&quot;open&quot;);<br>&nbsp;&nbsp;&nbsp; if(fdOut &lt; 0){
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Opening /dev/vme_m0 failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));<br>&nbsp;&nbsp;&nbsp; perror(&quot;memset&quot;);<br><br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowNbr
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowEnable&nbsp;&nbsp; &nbsp; = 1;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.wrPostEnable&nbsp;&nbsp; &nbsp;&nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.userAccessType&nbsp; = VME_SUPER;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.dataAccessType&nbsp; = VME_DATA;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowSizeL
&nbsp;&nbsp; &nbsp; &nbsp; = 0x200000;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.xferProtocol&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; = VME_SCT;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.addrSpace &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; = VME_A24;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.maxDataWidth &nbsp;&nbsp;&nbsp; = VME_D16;<br><br>&nbsp;&nbsp;&nbsp; status = ioctl(fdOut, VME_IOCTL_SET_OUTBOUND, &amp;outWinCfgADC);
<br>&nbsp;&nbsp;&nbsp; perror(&quot;ioctl&quot;);<br>&nbsp;&nbsp;&nbsp; if(status &lt; 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** ioctl set on outWinCfgADC failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; memset(&amp;outWinGetADC, 0, sizeof(vmeOutWindowCfg_t));
<br>&nbsp;&nbsp;&nbsp; outWinGetADC.windowNbr = 0;<br><br>&nbsp;&nbsp;&nbsp; status = ioctl(fdOut, VME_IOCTL_GET_OUTBOUND, &amp;outWinGetADC);<br>&nbsp;&nbsp;&nbsp; perror(&quot;ioctl&quot;);<br>&nbsp;&nbsp;&nbsp; if(status &lt; 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** ioctl get on outWinGetADC failed. Errno = %d\n&quot;, errno);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; /* <br>&nbsp;&nbsp;&nbsp;&nbsp; * Check wheather the get and set configurations are the same <br>&nbsp;&nbsp;&nbsp;&nbsp; */<br><br>&nbsp;&nbsp;&nbsp; getPtr = (u_char *) mmap(0, outWinCfgADC.windowSizeL, PROT_READ|PROT_WRITE, MAP_SHARED, fdOut, 0);
<br>&nbsp;&nbsp;&nbsp; perror(&quot;mmap&quot;);<br>&nbsp;&nbsp;&nbsp; printf(&quot;# Start of outbound win in virtual address space of the process: %p\n&quot;, getPtr);<br><br>&nbsp;&nbsp;&nbsp; rdPtr = getPtr;<br><br>&nbsp;&nbsp;&nbsp; for(i=0;i&lt;0x100;i++){<br>&nbsp; &nbsp; &nbsp;&nbsp; printf(&quot;# Read at address %x = %x\n&quot;, rdPtr, *rdPtr);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rdPtr++;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; status = close(fdOut);<br>&nbsp;&nbsp;&nbsp; if(status != 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** close() failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br>
<br>__________________________________<br>Part of the output:<br><br>mmap: Illegal seek<br># Start of outbound win in virtual address space of the process: 0x30029000<br># Read at address 30029000 = ff<br># Read at address 30029001 = ff
<br># Read at address 30029002 = ff<br># Read at address 30029003 = ff<br># Read at address 30029004 = ff<br># Read at address 30029005 = ff<br># Read at address 30029006 = ff<br># Read at address 30029007 = ff<br># Read at address 30029008 = ff
<br># Read at address 30029009 = ff<br># Read at address 3002900a = ff<br># Read at address 3002900b = ff<br><br>and etc.<br>

------=_Part_257142_19717382.1174922094648--
