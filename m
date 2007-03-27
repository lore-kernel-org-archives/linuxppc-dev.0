Return-Path: <kkboyanov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 34DEBDDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 01:47:39 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1791535ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 08:47:37 -0700 (PDT)
Message-ID: <929bf310703270847k364986cbrbe70f0e726ab487f@mail.gmail.com>
Date: Tue, 27 Mar 2007 17:47:04 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Reading and writing from/to VME device
In-Reply-To: <4608DF55.90508@in2p3.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10858_31113920.1175010424049"
References: <929bf310703260814q18957942s218d56bed8fb4009@mail.gmail.com>
	<4608DF55.90508@in2p3.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_10858_31113920.1175010424049
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

First of all, thanks for the feedback!

@Tim Martin:
>I'm not sure what a "Linux v3.5" is - Montavista?  There are patches
>available from Motorola to the vanila kernel if you're interested in
>using something newer than 2.6.15.

Well, 3.5 is just the version of the driver, which is shown by
# cat /proc/vmeinfo
Otherwise, I'm using ELinOS 4.1 for building the linux system. And as for
now I think the 2.6.15 is fine for testing purposes.

>The target VME address will be 0x00000000, since you didn't configure
>the .xlatedAddrU or .xlatedAddrL portions of outWinCfgADC.  Typically,
>the VME address space is partitioned by VME chassis slot number or some
>other application-specific scheme.

I tried to assign it to some other value (just a guess like 0x10000000,
which I think is 0x1000 in A16), and then try to read through as many
addresses as the size of the window contains. I get the following output
(source again @EOM):

# Read @ VME address a000 = 0
# Read @ VME address a002 = 0
# Read @ VME address a004 = 1
# Read @ VME address a006 = 0
# Read @ VME address a008 = 0
# Read @ VME address a00c = eda2
# Read @ VME address a00e = eda2
# Read @ VME address a010 = 0
# Read @ VME address a012 = 0
# Read @ VME address a014 = 0
# Read @ VME address a016 = 0
# Read @ VME address a018 = 0
# Read @ VME address a01a = 0
# Read @ VME address a01c = 0
# Read @ VME address a020 = 0
# Read @ VME address a080 = 4546
# Read @ VME address a082 = 5f4c
# Read @ VME address a084 = 4146
# Read @ VME address a086 = 4344
# Read @ VME address a088 = 4445
# Read @ VME address a08a = 5953
# Read @ VME address a08c = 3
# Read @ VME address a08e = 3
# Read @ VME address a090 = 2
# Read @ VME address a092 = 0
# Read @ VME address a094 = 0
# Read @ VME address a096 = 0
# Read @ VME address a098 = 0
# Read @ VME address a09a = 0
# Read @ VME address a09c = 0
# Read @ VME address a09e = e369

repeatedly for all addresses up to 0xFD04F when I get a Segmentation fault.
At least now I got something, but I just cannot figure out why the output
repeats again and again about 20-30. The ADC board is in slot 4, and it's
CSR space is available at 0x10100000 (set by junpers) , containing 15
registers. Is it possible that I'm actualy accessing them, or I just read
garbage?

>Typically, the VME address space is partitioned by VME chassis slot number
or some
>other application-specific scheme.
Does this mean that (theoretically) all slots (respectively boards in them)
are visible through a single outbound window? Or one must configure one
outbound window per slot?
I tried ot find some more info on this issue but with no success. I only
found something similar to what you are refering in the driver
documentation, but it is about the inbound windows, not the outbound ones.
The schema for the inbound wins is the following:

Each of the inbound windows is mapped into A32/D32 space at an address
determined by the boards slot
number. The address is calculated as
0x80000000+(0x20000000*slotnum)+(0x400000*inboundnum).
Thus, in total, each board responds to a 32 MB chunk of VME address space.

I don't know whether the schema for the outbound wins is the same, or where
to find it. Maybe its driver specific, in other words defined by some driver
function? Can somebody shed some light on this please?

@Didier Kryn:
>  1) You declare outWinCfg and use later in the code outWinCfgADC. I
>guess the compiler will complain, unless I missed something. I guess
>this is not the file you actually compiled.
This is just a typo, and yes, that's not the code that I compiled, just a
"snippet" to illustrate how I've really implemented my ideas.
About the MAP_SHARED flag - after getting over the VME accesses I'll have to
integrate the API to the VME bus ina control server, which uses shared
memory when reading out the data from the ADC, so I thought it would be a
good idea to test with shared memory in the first place.

Thanks again for all the help.

Best regards,
Konstantin
_______________________________________

int main(int argc, char ** args)
{
    vmeInfoCfg_t      outWinCfgInfo;
    vmeOutWindowCfg_t outWinCfgADC;
    vmeOutWindowCfg_t outWinGetADC;

    int fdOut, status, i, j;
    unsigned int  n;
    unsigned short *rdPtr, *getPtr;

    fdOut = open("/dev/vme_m0", O_RDWR);
    perror("open");
    if(fdOut < 0){
      printf("Opening /dev/vme_m0 failed. Errno = %d\n", errno);
    }

    memset(&outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));
    perror("memset");

    outWinCfgADC.windowNbr        = 0;
    outWinCfgADC.windowEnable    = 1;
    outWinCfgADC.wrPostEnable    = 0;
    outWinCfgADC.userAccessType = VME_SUPER;
    outWinCfgADC.dataAccessType = VME_DATA;
    outWinCfgADC.windowSizeL    = 0x200000;
    outWinCfgADC.xferProtocol   = VME_SCT;
    outWinCfgADC.addrSpace         = VME_A16;
    outWinCfgADC.maxDataWidth     = VME_D16;
    outWinCfgADC.xlatedAddrL    = 0x10000000;

    status = ioctl(fdOut, VME_IOCTL_SET_OUTBOUND, &outWinCfgADC);
    perror("ioctl");
    if(status < 0){
        printf("*** ioctl set on outWinCfgADC failed. Errno = %d\n", errno);
        exit (1);
    }

    memset(&outWinGetADC, 0, sizeof(vmeOutWindowCfg_t));
    perror("memset");
    outWinGetADC.windowNbr = 0;

    status = ioctl(fdOut, VME_IOCTL_GET_OUTBOUND, &outWinGetADC);
    perror("ioctl");
    if(status < 0){
        printf("*** ioctl get on outWinGetADC failed. Errno = %d\n", errno);
        exit (1);
    }

    getPtr = (unsigned short *) mmap(0, outWinCfgADC.windowSizeL,
PROT_READ|PROT_WRITE, MAP_SHARED, fdOut, 0);
    perror("mmap");
    printf("# Start of outbound win in virtual address space of the process:
%p\n", getPtr);

    rdPtr = getPtr;

    for(i = 0; i < 0x200000 ; i++)
    {
        if((*rdPtr)!=0xFFFF){
            printf("%x = %x\n", i, *rdPtr);
        }
        rdPtr++;
       }

    status = close(fdOut);
    if(status != 0){
        printf("*** close() failed. Errno = %d\n", errno);
        exit (1);
    }
    return 0;
}

------=_Part_10858_31113920.1175010424049
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>First of all, thanks for the feedback!<br><br>@Tim Martin:<br>&gt;I&#39;m not sure what a &quot;Linux v3.5&quot; is - Montavista? &nbsp;There are patches<br>&gt;available from Motorola to the vanila kernel if you&#39;re interested in
<br>&gt;using something newer than 2.6.15.<br><br>Well, 3.5 is just the version of the driver, which is shown by <br># cat /proc/vmeinfo<br>Otherwise, I&#39;m using ELinOS 4.1 for building the linux system. And as for now I think the 
2.6.15 is fine for testing purposes.<br><br>&gt;The target VME address will be 0x00000000, since you didn&#39;t configure<br>&gt;the .xlatedAddrU or .xlatedAddrL portions of outWinCfgADC. &nbsp;Typically,<br>&gt;the VME address space is partitioned by VME chassis slot number or some
<br>&gt;other application-specific scheme.<br><br>I tried to assign it to some other value (just a guess like 0x10000000, which I think is 0x1000 in A16), and then try to read through as many&nbsp; addresses as the size of the window contains. I get the following output (source again @EOM):
<br><br># Read @ VME address a000 = 0<br># Read @ VME address a002 = 0<br># Read @ VME address a004 = 1<br># Read @ VME address a006 = 0<br># Read @ VME address a008 = 0<br># Read @ VME address a00c = eda2<br># Read @ VME address a00e = eda2
<br># Read @ VME address a010 = 0<br># Read @ VME address a012 = 0<br># Read @ VME address a014 = 0<br># Read @ VME address a016 = 0<br># Read @ VME address a018 = 0<br># Read @ VME address a01a = 0<br># Read @ VME address a01c = 0
<br># Read @ VME address a020 = 0<br># Read @ VME address a080 = 4546<br># Read @ VME address a082 = 5f4c<br># Read @ VME address a084 = 4146<br># Read @ VME address a086 = 4344<br># Read @ VME address a088 = 4445<br># Read @ VME address a08a = 5953
<br># Read @ VME address a08c = 3<br># Read @ VME address a08e = 3<br># Read @ VME address a090 = 2<br># Read @ VME address a092 = 0<br># Read @ VME address a094 = 0<br># Read @ VME address a096 = 0<br># Read @ VME address a098 = 0
<br># Read @ VME address a09a = 0<br># Read @ VME address a09c = 0<br># Read @ VME address a09e = e369<br><br>repeatedly for all addresses up to 0xFD04F when I get a Segmentation fault. At least now I got something, but I just cannot figure out why the output repeats again and again about 20-30. The ADC board is in slot 4, and it&#39;s CSR space is available at 0x10100000 (set by junpers) , containing 15 registers. Is it possible that I&#39;m actualy accessing them, or I just read garbage?
<br><br>&gt;Typically, the VME address space is partitioned by VME chassis slot number or some
<br>&gt;other application-specific scheme.<br>Does this mean that (theoretically) all slots (respectively boards in them) are visible through a single outbound window? Or one must configure one outbound window per slot?<br>

I tried ot find some more info on this issue but with no success. I only found something similar to what you are refering in the driver documentation, but it is about the inbound windows, not the outbound ones. The schema for the inbound wins is the following:
<br><br>Each of the inbound windows is mapped into A32/D32 space at an address determined by the boards slot<br>number. The address is calculated as 0x80000000+(0x20000000*slotnum)+(0x400000*inboundnum). <br>Thus, in total, each board responds to a 32 MB chunk of VME address space.
<br><br>I don&#39;t know whether the schema for the outbound wins is the same, or where to find it. Maybe its driver specific, in other words defined by some driver function? Can somebody shed some light on this please?<br>

<br>@Didier Kryn:<br>
&gt;&nbsp; 1) You declare outWinCfg and use later in the code outWinCfgADC. I<br>
&gt;guess the compiler will complain, unless I missed something. I guess<br>
&gt;this is not the file you actually compiled.<br>This is just a typo,
and yes, that&#39;s not the code that I compiled, just a &quot;snippet&quot; to
illustrate how I&#39;ve really implemented my ideas.<br>About the MAP_SHARED flag - after getting over the VME accesses I&#39;ll have to integrate the API to the VME bus ina control server, which uses shared memory when reading out the data from the ADC, so I thought it would be a good idea to test with shared memory in the first place.
<br><br>Thanks again for all the help.<br><br>Best regards,<br>Konstantin<br>_______________________________________<br><br>int main(int argc, char ** args)<br>{<br>&nbsp;&nbsp;&nbsp; vmeInfoCfg_t&nbsp;&nbsp;&nbsp; &nbsp; outWinCfgInfo;<br>&nbsp;&nbsp;&nbsp; vmeOutWindowCfg_t outWinCfgADC;
<br>&nbsp;&nbsp;&nbsp; vmeOutWindowCfg_t outWinGetADC;<br><br>&nbsp;&nbsp;&nbsp; int fdOut, status, i, j;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; unsigned int&nbsp; n;<br>&nbsp;&nbsp;&nbsp; unsigned short *rdPtr, *getPtr;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; fdOut = open(&quot;/dev/vme_m0&quot;, O_RDWR);<br>&nbsp;&nbsp;&nbsp; perror(&quot;open&quot;);
<br>&nbsp;&nbsp;&nbsp; if(fdOut &lt; 0){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Opening /dev/vme_m0 failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; memset(&amp;outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));<br>&nbsp;&nbsp;&nbsp; perror(&quot;memset&quot;);<br>
&nbsp;  <br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowNbr&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowEnable&nbsp;&nbsp;&nbsp; = 1;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.wrPostEnable&nbsp;&nbsp;&nbsp; = 0;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.userAccessType = VME_SUPER;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.dataAccessType = VME_DATA;
<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.windowSizeL&nbsp;&nbsp;&nbsp; = 0x200000;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.xferProtocol&nbsp;&nbsp; = VME_SCT;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.addrSpace &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; = VME_A16;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.maxDataWidth &nbsp;&nbsp;&nbsp; = VME_D16;<br>&nbsp;&nbsp;&nbsp; outWinCfgADC.xlatedAddrL
&nbsp;&nbsp;&nbsp; = 0x10000000;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; status = ioctl(fdOut, VME_IOCTL_SET_OUTBOUND, &amp;outWinCfgADC);<br>&nbsp;&nbsp;&nbsp; perror(&quot;ioctl&quot;);<br>&nbsp;&nbsp;&nbsp; if(status &lt; 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** ioctl set on outWinCfgADC failed. Errno = %d\n&quot;, errno);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;  <br>&nbsp;&nbsp;&nbsp; memset(&amp;outWinGetADC, 0, sizeof(vmeOutWindowCfg_t));<br>&nbsp;&nbsp;&nbsp; perror(&quot;memset&quot;);<br>&nbsp;&nbsp;&nbsp; outWinGetADC.windowNbr = 0;<br><br>&nbsp;&nbsp;&nbsp; status = ioctl(fdOut, VME_IOCTL_GET_OUTBOUND, &amp;outWinGetADC);
<br>&nbsp;&nbsp;&nbsp; perror(&quot;ioctl&quot;);<br>&nbsp;&nbsp;&nbsp; if(status &lt; 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** ioctl get on outWinGetADC failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; getPtr = (unsigned short *) mmap(0, 
outWinCfgADC.windowSizeL, PROT_READ|PROT_WRITE, MAP_SHARED, fdOut, 0);<br>&nbsp;&nbsp;&nbsp; perror(&quot;mmap&quot;);<br>&nbsp;&nbsp;&nbsp; printf(&quot;# Start of outbound win in virtual address space of the process: %p\n&quot;, getPtr);<br>&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; rdPtr = getPtr;<br><br>&nbsp;&nbsp;&nbsp; for(i = 0; i &lt; 0x200000 ; i++)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if((*rdPtr)!=0xFFFF){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;%x = %x\n&quot;, i, *rdPtr);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rdPtr++;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; status = close(fdOut);
<br>&nbsp;&nbsp;&nbsp; if(status != 0){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;*** close() failed. Errno = %d\n&quot;, errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br>

------=_Part_10858_31113920.1175010424049--
