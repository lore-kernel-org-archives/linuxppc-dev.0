Return-Path: <linuxppcemb@lkmail.de>
Message-ID: <4EFEEF14.3070707@lkmail.de>
Date: Sat, 31 Dec 2011 12:16:36 +0100
From: Lorenz Kolb <linuxppcemb@lkmail.de>
MIME-Version: 1.0
To: "Wang, Junhua H. (NSN - CN/Hangzhou)" <junhua.h.wang@nsn.com>
Subject: Re: Ask a technical problem happened on PPC board
References: <E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net>
In-Reply-To: <E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net>
Content-Type: multipart/alternative;
 boundary="------------030204040203040409060301"
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030204040203040409060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

first of all: have you tried doing a standalone memory test application?
 From what I see you are using either a Virtex-4FX or Virtex-5FXT 
device, correct?

So I'd highly recommend doing a standalone test prior to booting Linux 
to verify the memory controller timings of the FPGA based SoC.

Apart from this: your Linux-Kernel and gcc seem to be pretty outdated. 
Using a more recent Linux and toolchain often solves a lot of issues (my 
experience, esp. with PowerPC Linux for Xilinx FPGAs).

Regards,

Lorenz
Missing Link Electronics

On 12/31/2011 5:15 AM, Wang, Junhua H. (NSN - CN/Hangzhou) wrote:
>
> HI, all:
>
> Sorry to disturb all of you in the linuxppc-dev mail group. I am a new 
> member from linuxppc-dev from China, and I have a very weird problem, 
> it have been bothering me for a long time.  I will be very grateful if 
> you can help me to analyse it.
>
>   1) Problem description:
>
> a) FRIU(a circuit board) unit is a ppc(powerpc) unit, 256 M bytes Ram, 
> bootloader is uboot, kernel linux-2.6.21 filesystem: initramfs
>
> The main problem is that when kernel start up and mount initramfs, run 
> the init process(pid 1), when the process(init) write file(20 M bytes) 
> to filesystem(initramfs),
>
> sometimes it will find some data modified when check the file's 
> contents by read it.
>
> b) I have write a test init process which will write 20 Mbytes 
> data(0xFF) to "/TEST0.IMG" and check it's contents. Sometimes, the 
> contents will by modified.
>
> c) Here is the test procedure:
>
> Uboot download linux kernel and initramfs --> cmd "bootm" to start 
> linux -->after kernel start complete, mount initramfs, run init 
> process(pid 1)
>
> --> It will write 20 Mbytes data(0XFF) to 'TEST0.IMG' and check it's 
> contents, If there is error, the error data will be printed.
>
> 2) Error data:
>
> a) Every time the error happened, a pair of data modified:
>
> first place: 1C 00 FF FF FF FF FF FF 00 00 00 040 80 ...
>
> Second place:FF FF FF FF FF FF 00 A0 ....
>
> Sometimes, there will be 2 pair of data modified.
>
> b) The error happens not very often, but it happens sometime.
>
> 3)
>
> Could you give me some advice on how to investigate it or which part 
> you think will have problem?
>
> Thanks very much!
>
> Usedkernel: linux-2.6.21<<init process write_read file(20Mbytes) 
> error2.txt>> <<init process write_read file(20Mbytes) error.txt>>
>
> Br,
>
> Wang Junhua
>
> *Wang Junhua (Jonny)*//
>
> /-----------------------------------------/
>
> /LINDX/
>
> /DX 200 R&D HZ Area E /
>
> /MP: +8615967154143/
>
> /Seat:4076/
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------030204040203040409060301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    first of all: have you tried doing a standalone memory test
    application?<br>
    From what I see you are using either a Virtex-4FX or Virtex-5FXT
    device, correct?<br>
    <br>
    So I'd highly recommend doing a standalone test prior to booting
    Linux to verify the memory controller timings of the FPGA based SoC.<br>
    <br>
    Apart from this: your Linux-Kernel and gcc seem to be pretty
    outdated. Using a more recent Linux and toolchain often solves a lot
    of issues (my experience, esp. with PowerPC Linux for Xilinx FPGAs).<br>
    <br>
    Regards,<br>
    <br>
    Lorenz<br>
    Missing Link Electronics<br>
    <br>
    On 12/31/2011 5:15 AM, Wang, Junhua H. (NSN - CN/Hangzhou) wrote:
    <blockquote
cite="mid:E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <meta name="Generator" content="MS Exchange Server version
        6.5.7654.12">
      <title>Ask a technical problem happened on PPC board</title>
      <!-- Converted from text/rtf format -->
      <p dir="LTR"><span lang="en-us"><font face="Calibri"
            color="#1F497D">HI, all:</font></span><span lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"><font face="Calibri">&nbsp;</font>
          <font face="Calibri">Sorry to disturb all of you in the
            linuxppc-dev mail group. I am a new member from linuxppc-dev
            from China, and I have a very weird problem, it have been
            bothering me for a long time.&nbsp; I will be very grateful if
            you can help me to analyse it.</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">&nbsp; 1) Problem</font> <font face="Calibri">description:</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">a) FRIU(a circuit board) unit is a
            ppc(powerpc) unit, 256 M bytes Ram, bootloader is uboot,
            kernel linux-2.6.21 filesystem: initramfs</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">The main problem is that when kernel start up
            and mount initramfs, run the init process(pid 1), when the
            proc</font><font face="Calibri">ess(init) write file(20 M
            bytes) to filesystem(initramfs),</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">sometimes it will find some data modified
            when check the file</font><font face="Calibri">&#8217;</font><font
            face="Calibri">s contents by read it. </font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">b) I have write a test init process which
            will write 20 Mbytes data(0xFF) to "/TEST0.IMG" and check
            it's conten</font><font face="Calibri">ts. Sometimes, the
            contents will by modified.</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">c) Here is the test procedure: </font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Uboot download linux kernel and initramfs
            --&gt; cmd "bootm" to start linux --&gt;</font></span><span
          lang="en-us"></span><span lang="en-us"> <font face="Calibri"
            color="#FF0000">after kernel start complete, mount
            initramfs, run init process(pid 1)</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span><span
          lang="en-us"><font face="Calibri">--&gt; It will write 20
            Mbytes dat</font><font face="Calibri">a(0XFF) to 'TEST0.IMG'
            and check it's contents, If there is error, the error data
            will be printed.</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">2) Error data:</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">a) Every time the error happened, a pair of
            data modified:</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">first place:&nbsp;</font></span><span lang="en-us"></span><span
          lang="en-us"> <font face="Calibri" color="#FF0000">1C 00 FF
            FF FF FF FF FF 00 00 00 040 80 ..</font></span><span
          lang="en-us"></span><span lang="en-us">.</span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Second place:</font></span><span lang="en-us"></span><span
          lang="en-us"> <font face="Calibri" color="#FF0000">FF FF FF F</font><font
            face="Calibri" color="#FF0000">F FF FF 00 A0 ....</font></span><span
          lang="en-us"></span><span lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Sometimes, there will be 2 pair of data
            modified.</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">b) The error happens not very often, but it
            happens sometime.</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">3)</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Could you give me some advice on how to
            investigate it or which part you think will have problem? </font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Thanks very much!</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Used</font><font face="Calibri"> kernel:
            linux-2.6.21</font></span><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"><font face="SimSun"
            color="#000000" size="2"> &lt;&lt;init process write_read
            file(20Mbytes) error2.txt&gt;&gt; </font></span><span
          lang="en-us"></span><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"></span><span
          lang="en-us"><font face="SimSun" color="#000000" size="2">
            &lt;&lt;init process write_read file(20Mbytes)
            error.txt&gt;&gt; </font></span><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Br,</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Wang Junhua</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span></p>
      <p dir="LTR"><span lang="en-us"></span><span lang="en-us"></span><b><span
            lang="en-us"></span><span lang="en-us"><font face="Arial
              Black" color="#808080">Wang Junhua (Jonny)</font></span></b><span
          lang="en-us"></span><span lang="en-us"></span><i><span
            lang="en-us"></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font face="Arial"
              color="#808080">-----------------------------------------</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font face="Arial"
              color="#808080">LINDX</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font face="Arial"
              color="#808080">DX 200 R&amp;D HZ Area E </font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font face="Arial"
              color="#808080">MP: +8615967154143</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font face="Arial"
              color="#808080">Seat:4076</font></span></i><span
          lang="en-us"></span><span lang="en-us"></span><span
          lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span></p>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030204040203040409060301--
