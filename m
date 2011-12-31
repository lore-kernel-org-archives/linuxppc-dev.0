Return-Path: <manuel.pezzin@free.fr>
Message-ID: <4EFECF84.4070705@free.fr>
Date: Sat, 31 Dec 2011 10:01:56 +0100
From: manu <manuel.pezzin@free.fr>
MIME-Version: 1.0
CC: Linuxppc-dev@lists.ozlabs.org
Subject: Re: Ask a technical problem happened on PPC board
References: <E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net>
In-Reply-To: <E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net>
Content-Type: multipart/alternative;
 boundary="------------060200020306040806060804"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060200020306040806060804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
it looks like a memory interface problem. This is a typical issue with 
FPGA-based PPC systems.
You should check/monitor carefully the hardware :
  - power supplies
  - memory controller configuration (RAS, CAS, banks...)
  - timing of pins connected to external memory
Prior to boot a linux kernel, you should test your board with an 
exhaustive standalone test program running from internal BRAM. In 
particular, you should run an intensive test of your external memory 
with cache enabled. Cache must be configured in copy back mode and test 
code must be written so that it causes a lot of cache misses.
Hope this helps.

Manu

Le 31/12/2011 05:15, Wang, Junhua H. (NSN - CN/Hangzhou) a écrit :
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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--------------060200020306040806060804
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Hi,<br>
    it looks like a memory interface problem. This is a typical issue
    with FPGA-based PPC systems.<br>
    You should check/monitor carefully the hardware :<br>
    &nbsp;- power supplies<br>
    &nbsp;- memory controller configuration (RAS, CAS, banks...)<br>
    &nbsp;- timing of pins connected to external memory<br>
    Prior to boot a linux kernel, you should test your board with an
    exhaustive standalone test program running from internal BRAM. In
    particular, you should run an intensive test of your external memory
    with cache enabled. Cache must be configured in copy back mode and
    test code must be written so that it causes a lot of cache misses.<br>
    Hope this helps.<br>
    <br>
    Manu<br>
    <br>
    Le 31/12/2011 05:15, Wang, Junhua H. (NSN - CN/Hangzhou) a &eacute;crit&nbsp;:
    <blockquote
cite="mid:E2D908A47720CD488BC2AFD11DB6A1B540E9A1@CNBEEXC007.nsn-intra.net"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <meta name="Generator" content="MS Exchange Server version
        6.5.7654.12">
      <title>Ask a technical problem happened on PPC board</title>
      <!-- Converted from text/rtf format -->
      <p dir="LTR"><span lang="en-us"><font color="#1f497d"
            face="Calibri">HI, all:</font></span><span lang="en-us"></span></p>
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
          lang="en-us"></span><span lang="en-us"> <font color="#ff0000"
            face="Calibri">after kernel start complete, mount initramfs,
            run init process(pid 1)</font></span></p>
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
          lang="en-us"> <font color="#ff0000" face="Calibri">1C 00 FF
            FF FF FF FF FF 00 00 00 040 80 ..</font></span><span
          lang="en-us"></span><span lang="en-us">.</span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Second place:</font></span><span lang="en-us"></span><span
          lang="en-us"> <font color="#ff0000" face="Calibri">FF FF FF F</font><font
            color="#ff0000" face="Calibri">F FF FF 00 A0 ....</font></span><span
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
          lang="en-us"></span><span lang="en-us"><font color="#000000"
            face="SimSun" size="2"> &lt;&lt;init process write_read
            file(20Mbytes) error2.txt&gt;&gt; </font></span><span
          lang="en-us"></span><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"></span><span
          lang="en-us"><font color="#000000" face="SimSun" size="2">
            &lt;&lt;init process write_read file(20Mbytes)
            error.txt&gt;&gt; </font></span><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Br,</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"><font
            face="Calibri">Wang Junhua</font></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span></p>
      <p dir="LTR"><span lang="en-us"></span><span lang="en-us"></span><b><span
            lang="en-us"></span><span lang="en-us"><font color="#808080"
              face="Arial Black">Wang Junhua (Jonny)</font></span></b><span
          lang="en-us"></span><span lang="en-us"></span><i><span
            lang="en-us"></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font color="#808080"
              face="Arial">-----------------------------------------</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font color="#808080"
              face="Arial">LINDX</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font color="#808080"
              face="Arial">DX 200 R&amp;D HZ Area E </font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font color="#808080"
              face="Arial">MP: +8615967154143</font></span></i></p>
      <p dir="LTR"><i><span lang="en-us"><font color="#808080"
              face="Arial">Seat:4076</font></span></i><span lang="en-us"></span><span
          lang="en-us"></span><span lang="en-us"></span></p>
      <p dir="LTR" align="JUSTIFY"><span lang="en-us"></span></p>
      <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
  </body>
</html>

--------------060200020306040806060804--
