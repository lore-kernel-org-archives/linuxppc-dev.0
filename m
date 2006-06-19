Return-Path: <npk_0@yahoo.co.in>
Received: from web8908.mail.in.yahoo.com (web8908.mail.in.yahoo.com
	[203.84.221.140]) by ozlabs.org (Postfix) with SMTP id E920167B1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Jun 2006 14:49:26 +1000 (EST)
Message-ID: <20060619044924.96337.qmail@web8908.mail.in.yahoo.com>
Date: Mon, 19 Jun 2006 05:49:24 +0100 (BST)
From: Prakash N <npk_0@yahoo.co.in>
Subject: Linux Audio Xilinx board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-75631034-1150692564=:95530"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-75631034-1150692564=:95530
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Hi all,
 I'm developing an IP Phone which has to be optimized for cost.  I thought of prototyping, the application on Xilinx Board (http://www.xilinx.com/univ/xupv2p.html (or) www.digilentinc.com/xupv2p). Xilinx had given the OS support thro' Montavista, VxWorks. The montavista Linux which is supported & "open source" is available with the kernel 2.4.26. I used www.eecs.wsu.edu/~jamie/research/LinuxPort/linux_port.htm as a reference for porting linux on xilinx board. Since I'm more into VLSI than embedded designs I dont know much about the later.
 
 Now coming to problem, Xilinx had given BSPs for Ethernet, UART, Compact Flash etc , which I can replace it in the Montavista distribution and I can configure and compile the kernel for the same. What I mean here is the montavista linux distribution doesnt have the xilinx BSPs, which I need to put in their distribution, before configuration & compilation. But the Xilinx had not given the BSP for Audio Codec, which is available in the board.
 
 But as per the work done by Jamie, http://www.eecs.wsu.edu/~jamie/research/designs/audio_test /Audio%20Test.doc
 http://www.eecs.wsu.edu/~jamie/research/designs/audio_test/7.1i.zip
 
Coming to my application, Linphone (www.linphone.org), an open source
VoIP phone, I could compile and run it on FC4 Linux x86 computer. Also
I cross compiled the same on powerPC-405 platform using cross
compiling tools. Since audio support/device driver is not provided
under montavista (compatible to Xilinx board) I couldnt test the
audio, which is very important in phone kind of products.
I could see the ac97 Codec (LM4550 chip) in the board. Also I could
see ac97 related files in two places,
1) Under Xilinx supplied software
2) Under Montavista Linux distribution

Probably I may need to  change the ac97 files in montavista with "some
modifications" in Xilinx provided files. Here "some modifications" is
the advice given by Jamie (transcript is given below), which she had
stopped replying after some time.

I\'d attached the
1.Xilinx provided BSPs which I replace in monta vista distribution.
(attached as temp.zip)
2.ac97 files provided by Xilinx (xac97_l.c & xac97_l.h)
3.ac97 related files by Montavista  (ac97*.*) as given in
linuxppc_2_4_devel folder

The linphone is trying to check /dev/dsp for audio i/o and I just need
OSS rather ALSA, as later is not supported in Linux 2.4.

Now if you can say how can I make a driver / adapter in linux for
Linphone, so that it can access the xilinx board specific Audio Codec.

------------------------------------------------------------------------------------------------------------------------
Transcripts of mails with Jamie
------------------------------------------------------------------------------------------------------------------------Prakash,

- Hide quoted text -
",1] );  //-->I could able to test the Mic (Mike, Speaker input) & speaker (speaker  output), as a stand alone application (not on linux) running on board. 

Coming to my application, Linphone (www.linphone.org), an open source VoIP phone, I could compile and run it on FC4 Linux x86 computer. Also I cross compiled the same on powerPC-405 platform using cross compiling tools. Since audio support/device driver is not provided under montavista (compatible to Xilinx board) I couldnt test the audio, which is very important in phone kind of products.
I could see  the ac97  Codec (LM4550 chip) in the board. Also I could see ac97 related  files in two places, 
1) Under Xilinx supplied software
2) Under Montavista  Linux distribution

Probably I may need to change the ac97 files in montavista with "some modifications" in Xilinx provided files. Here "some modifications" is the advice given by Jamie (transcript is given below), which she had stopped replying after some time.

The linphone is trying to check /dev/dsp for audio i/o and I just need OSS rather ALSA, as later is not supported in Linux 2.4.

Now if you can say how can I make a driver / adapter in linux for Linphone, so that it can access the xilinx board specific Audio Codec.
 Also I want to know whether there is Linux 2.6 version available for xilinx board, which does have the BSPs for the same.

------------------------------------------------------------------------------------------
Transcripts  of mails with  Jamie
 ------------------------------ ------------------------------------------------------------

Prakash,

Sorry about the delay. I was out of town for a while.
If you track down Xilinx device driver functions, you\'ll
see that they use their own IO functions. These functions
are specific to Xilinx products, and so they can\'t be used directly
under Linux. The memory mapped IO driver I wrote can be used to
replace these functions. You basically create a character device on
your own, so that the device can be read/write in Linux. I assume you
have a good
programming knowledge, so just look into the AC97
device driver, and track down to the lowest level IO.
>From there, use the Linux IO driver to  replace these functions. I hope
this helps.

-Jamie


----- Original Message -----
From: "Prakash N" <nprakash@cedt.iisc.ernet.in>
To: "Jamie Lin" <jamiehl@mail.wsu.edu>
Sent: Thursday, May 04, 2006 11:16 PM
Subject: RE: XILINX board-Audio Codec-Linux driver support


> Jamie,
> Could you please brief me how can I proceed in developing the
> driver/adapter for linux-xilinx combination. Just give me some steps
> for this audio support. Like, just outline what I need to do, then I
> can proceed. I feel I may have to modify/add xilinx hardware related
> stuff to AC97 general linux drivers.
> Please guide  me in this.
> Sincerely,
> Prakash
>
> -----Original Message-----
> From: Jamie Lin [mailto:jamiehl@mail.wsu.edu]
> Sent: Monday, May 01, 2006 10:25 PM
> To: Prakash N
> Subject: Re: XILINX board-Audio Codec-Linux driver support
>
>
> No, you can\'t just use these files under Linux. Xilinx has its way of
",1] );  //--> 
Sorry about the delay. I was out of town for a while.
If you track down  Xilinx device driver functions, you'll
see that they use their own IO  functions. These functions
are specific to Xilinx products, and so they can't  be used directly
under Linux. The memory mapped IO driver I wrote can be used  to
replace these functions. You basically create a character device  on
your own, so that the device can be read/write in Linux.  I assume  you
have a good
programming knowledge, so just look into the  AC97
device driver, and track down to the lowest level IO.
>From there, use  the Linux IO driver to replace these functions. I hope
this  helps.

-Jamie


----- Original Message -----
From: "Prakash  N" <nprakash@cedt.iisc.ernet.in>
To:  "Jamie Lin" <jamiehl@mail.wsu.edu>
Sent:  Thursday, May 04, 2006 11:16 PM
Subject: RE: XILINX board-Audio Codec-Linux  driver support


> Jamie,
> Could you please brief me how can  I proceed in developing the
> driver/adapter for linux-xilinx combination.  Just give me some steps
> for this audio support. Like, just outline what  I need to do, then I
> can proceed. I feel I may have  to modify/add xilinx  hardware related
> stuff to AC97 general linux drivers.
> Please  guide me in this.
> Sincerely,
> Prakash
>
>  -----Original Message-----
> From: Jamie Lin [mailto:jamiehl@mail.wsu.edu]
> Sent:  Monday, May 01, 2006 10:25 PM
> To: Prakash N
> Subject: Re: XILINX  board-Audio Codec-Linux driver support
>
>
> No, you can't  just use these files under Linux. Xilinx has its way of
 > be used to make Xilinx drivers. All drivers in EDK only work under
> specific Xilinx platforms. That\'s why when we want to run Ethernet in
> Linux, we need to copy BSP to Linux, so that it knows a specific type
> of Ethernet needs to be made. We only replace files that  comes with
> BSP in Linux. The rest of driver files in Linux are used to adapt the
> device. If mv_linux BSP doesn\'t generate the device drivers for some
> of your devices in the base system, it means that device is not
> supported under Linux. To conclude, you need to write a custom AC97
> adapter in order to make it work in Linux.
>
> -Jamie
>
>
> ----- Original Message -----
> From: "Prakash N" <nprakash@cedt.iisc.ernet.in>
> To: "Jamie Lin" <jamiehl@mail.wsu.edu>
> Sent: Sunday, April 30, 2006 11:58 PM
> Subject: RE: XILINX board-Audio Codec-Linux driver support
>
>
> >  Jamie,
> > Iam confused with bsp folders. I just updated EDK with this,
> > http://www.xilinx.com/univ/XUPV2P/lib/lib_rev_1_1.zip
> > In that I could see EDK\\sw\\XilinxProcessorIPLib\\drivers\\ac97_v2_00_a
> > having data and src dirs which contains,
> > Data --> ac97_v2_1_0.tcl, ac97_v2_1_0.mdd
> > Src --> xac97_l.h ,xac97_l.c , Makefile
> > Is it not possible to use these drivers, by copying and pasting in
> > EDK\\sw\\ThirdParty\\bsp\\linux_mvl31_v1_01_a\\drivers
",1] );  //--> > making device drivers to adapt their platforms. The Makefiles can  only
> be used to make Xilinx drivers. All drivers in EDK only work  under
> specific Xilinx platforms. That's why when we want to  run Ethernet  in
> Linux, we need to copy BSP to Linux, so that it knows a specific  type
> of Ethernet needs to be made. We only replace files that comes  with
> BSP in Linux. The rest of driver files in Linux are used to adapt  the
> device. If mv_linux BSP doesn't generate the device drivers for  some
> of your devices in the base system, it means that device is  not
> supported under Linux. To conclude, you need to write a custom  AC97
> adapter in order to make it work in Linux.
>
>  -Jamie
>
>
> ----- Original Message -----
> From:  "Prakash N" <nprakash@cedt.iisc.ernet.in>
>  To: "Jamie Lin" <jamiehl@mail.wsu.edu>
> Sent:  Sunday, April 30, 2006 11:58 PM
>  Subject: RE: XILINX board-Audio  Codec-Linux driver support
>
>
> > Jamie,
> > Iam  confused with bsp folders. I just updated EDK with this,
> > http://www.xilinx.com/univ/XUPV2P/lib/lib_rev_1_1.zip
>  > In that I could see  EDK\sw\XilinxProcessorIPLib\drivers\ac97_v2_00_a
> > having data  and src dirs which contains,
> > Data --> ac97_v2_1_0.tcl,  ac97_v2_1_0.mdd
> > Src --> xac97_l.h ,xac97_l.c , Makefile
>  > Is it not possible to use these drivers, by copying and pasting in
>  > EDK\sw\ThirdParty\bsp\linux_mvl31_v1_01_a\drivers
 > > Please clarify,
> > Prakash
> >
> >
> > -----Original Message-----
>  > From: Jamie Lin [mailto:jamiehl@mail.wsu.edu]
> > Sent: Monday, May 01, 2006 9:49 AM
> > To: Prakash N
> > Subject: Re: XILINX board-Audio Codec-Linux driver support
> >
> >
> > Prakash,
> >
> > The BSP only offers a limit number of necessary drivers. You\'ll have
> > to write custom drivers on your own if they\'re not included. One thing
>
> > you can do is to use the sample IO driver I\'ve written to replace
> > low
> > level IOs in the Xilinx AC97 codec driver. This will take you some
> > time, but is a way to adapt AC97 codec in Linux that I can think of.
> > Other than this approach, I haven\'t seen any ready to use driver for
> > this codec.
> >
> > -Jamie
> >
> >
> > ----- Original Message -----
> > From: <nprakash@cedt.iisc.ernet.in>
> > To: <jamiehl@mail.wsu.edu>
> > Sent: Friday, April 28, 2006 5:23 AM
> > Subject: XILINX board-Audio Codec-Linux driver support
> >
> >
> > > Jamie Lin,
> > > I could follow your doc and successfully ported the Linux in the
> > > board. I
> > just
> > > want to know how can I add the audio codec drivers in linux. I
> > > mean,
>
> > > I
> > couldnt
> > > see the Audio Codec in "Connected Peripherals" in Library & OS
",1] );  //--> > > and run libgen .....
> > Please clarify,
> >  Prakash
> >
> >
> > -----Original  Message-----
> > From: Jamie Lin [mailto:jamiehl@mail.wsu.edu]
> > Sent:  Monday, May 01, 2006 9:49 AM
> > To: Prakash N
> > Subject:  Re: XILINX board-Audio Codec-Linux driver support
> >
>  >
> > Prakash,
> >
> > The BSP only offers a limit  number of necessary drivers. You'll have
> > to write custom drivers on  your own if they're not included. One thing
>
> > you can do is  to use the sample IO driver I've written to replace
> > low
>  > level IOs in the Xilinx AC97 codec driver. This will take you some
>  > time, but is a way to adapt AC97 codec in Linux that I can think  of.
>  > Other than this approach, I haven't seen any ready to use  driver for
> > this codec.
> >
> > -Jamie
>  >
> >
> > ----- Original Message -----
> > From:  <nprakash@cedt.iisc.ernet.in>
>  > To: <jamiehl@mail.wsu.edu>
> >  Sent: Friday, April 28, 2006 5:23 AM
> > Subject: XILINX board-Audio  Codec-Linux driver support
> >
> >
> > > Jamie  Lin,
> > > I could follow your doc and successfully ported the Linux  in the
> > > board. I
> > just
> > > want to  know how can I add the audio codec drivers in linux. I
> > >  mean,
>
> > > I
> > couldnt
> > >  see the  Audio Codec in "Connected Peripherals" in Library & OS
 >
> > > see its there
> > with
> > > all version, base address... defined. How can I add this in that
> > > so
> > > that
> > thro\'
> > > libgen I can add drivers for that also.
> > > Regards
> > > Prakash

------------------------------------------------------------------------------------------------------------------------

I feel I\'d given whatever possible details, still If something is
missing, Please ask the same.
Prakash

",1] ); D(["mb","


--
N.Prakash
Bangalore
+919448787632


",0] );  D(["ma",[1,"2 attachments — Scanning for viruses...temp.zip
294K linuxaudio.zip
22K ","10bd14d0c40a4b1e"] ] );  //--> > > > parameters (software platform settings). But in the hardware I  could
>
> > > see its there
> > with
> >  > all version, base address... defined. How can I add this in that
>  > > so
> > > that
> > thro'
> > > libgen  I can add drivers for that also.
> > > Regards
>  > >  Prakash

---------------------------------------------------------------------------------------------------

I  feel I'd given whatever possible details, still If something is
missing,  Please ask the same.
N.Prakash
ME Final Year- Microelectronics
CEDT-IISc
Bangalore
India
 
 				
---------------------------------
  Yahoo! India Answers: Share what you know. Learn something new Click here
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
--0-75631034-1150692564=:95530
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Hi all,<br> I'm developing an IP Phone which has to be optimized for cost.  I thought of prototyping, the application on Xilinx Board (<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.xilinx.com/univ/xupv2p.html">http://www.xilinx.com/univ<wbr>/xupv2p.html</a> (or) <a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.digilentinc.com/xupv2p">www.digilentinc.com/xupv2p</a>). Xilinx had given the OS support thro' Montavista, VxWorks. The montavista Linux which is supported &amp; "open source" is available with the kernel 2.4.26. I used <a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.eecs.wsu.edu/%7Ejamie/research/LinuxPort/linux_port.htm">www.eecs.wsu.edu/~jamie<wbr>/research/LinuxPort/linux_port<wbr>.htm</a> as a reference for porting linux on xilinx board. Since I'm more into VLSI than embedded designs I dont know much about the later.<br> <br>
 Now coming to problem, Xilinx had given BSPs for Ethernet, UART, Compact Flash etc , which I can replace it in the Montavista distribution and I can configure and compile the kernel for the same. What I mean here is the montavista linux distribution doesnt have the xilinx BSPs, which I need to put in their distribution, before configuration &amp; compilation. But the Xilinx had not given the BSP for Audio Codec, which is available in the board.<br> <br> But as per the work done by Jamie, <a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.eecs.wsu.edu/%7Ejamie/research/designs/audio_test/Audio%20Test.doc">http://www.eecs.wsu.edu/~jamie<wbr>/research/designs/audio_test /Audio%20Test.doc</a><br> <a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.eecs.wsu.edu/%7Ejamie/research/designs/audio_test/7.1i.zip">http://www.eecs.wsu.edu/~jamie<wbr>/research/designs/audio_test/7<wbr>.1i.zip</a><br>
 <cursive><!-- D(["mb","output), as a stand alone application (not on linux) running on board.<br /><br />Coming to my application, Linphone (<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"http://www.linphone.org\" \u003d_blank>www.linphone.org</a>), an open source<br />VoIP phone, I could compile and run it on FC4 Linux x86 computer. Also<br />I cross compiled the same on powerPC-405 platform using cross<br />compiling tools. Since audio support/device driver is not provided<br />under montavista (compatible to Xilinx board) I couldnt test the<br />audio, which is very important in phone kind of products.<br />I could see the ac97 Codec (LM4550 chip) in the board. Also I could<br />see ac97 related files in two places,<br />1) Under Xilinx supplied software<br />2) Under Montavista Linux distribution<br /><br />Probably I may need to  change the ac97 files in montavista with &quot;some<br />modifications&quot; in Xilinx
 provided files. Here &quot;some modifications&quot; is<br />the advice given by Jamie (transcript is given below), which she had<br />stopped replying after some time.<br /><br />I\'d attached the<br />1.Xilinx provided BSPs which I replace in monta vista distribution.<br />(attached as temp.zip)<br />2.ac97 files provided by Xilinx (xac97_l.c &amp; xac97_l.h)<br />3.ac97 related files by Montavista &nbsp;(ac97*.*) as given in<br />linuxppc_2_4_devel folder<br /><br />The linphone is trying to check /dev/dsp for audio i/o and I just need<br />OSS rather ALSA, as later is not supported in Linux 2.4.<br /><br />Now if you can say how can I make a driver / adapter in linux for<br />Linphone, so that it can access the xilinx board specific Audio Codec.<br /><br />------------------------------<wbr />------------------------------<wbr />------------------------------<wbr  />------------------------------<br />Transcripts of mails with Jamie<br
 />------------------------------<wbr />------------------------------<wbr />------------------------------<wbr />-----------------------------<wbr />-Prakash,<br /><br />- Hide quoted text -<br />",1] );  //-->I could able to test the Mic (Mike, Speaker input) &amp; speaker (speaker&nbsp; output), as a stand alone application (not on linux) running on board. <br><br>Coming to my application, Linphone (<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.linphone.org/">www.linphone.org</a>), an open source VoIP phone, I could compile and run it on FC4 Linux x86 computer. Also I cross compiled the same on powerPC-405 platform using cross compiling tools. Since audio support/device driver is not provided under montavista (compatible to Xilinx board) I couldnt test the audio, which is very important in phone kind of products.<br>I could see  the ac97  Codec (LM4550 chip) in the board. Also I could see ac97 related  files in two places,
 <br>1) Under Xilinx supplied software<br>2) Under Montavista  Linux distribution<br><br>Probably I may need to change the ac97 files in montavista with "some modifications" in Xilinx provided files. Here "some modifications" is the advice given by Jamie (transcript is given below), which she had stopped replying after some time.<br><br>The linphone is trying to check /dev/dsp for audio i/o and I just need OSS rather ALSA, as later is not supported in Linux 2.4.<br><br>Now if you can say how can I make a driver / adapter in linux for Linphone, so that it can access the xilinx board specific Audio Codec.<br> Also I want to know whether there is Linux 2.6 version available for xilinx board, which does have the BSPs for the same.<br><br>------------------------------------------------------------------------------------------<br></cursive>Transcripts  of mails with  Jamie<br> ------------------------------ <div style="direction:
 ltr;"><wbr>------------------------------<wbr>------------------------------<wbr><wbr><br><br>Prakash,<br><br><cursive><!-- D(["mb","<br />Sorry about the delay. I was out of town for a while.<br />If you track down Xilinx device driver functions, you\'ll<br />see that they use their own IO functions. These functions<br />are specific to Xilinx products, and so they can\'t be used directly<br />under Linux. The memory mapped IO driver I wrote can be used to<br />replace these functions. You basically create a character device on<br />your own, so that the device can be read/write in Linux. I assume you<br />have a good<br />programming knowledge, so just look into the AC97<br />device driver, and track down to the lowest level IO.<br />From there, use the Linux IO driver to  replace these functions. I hope<br />this helps.<br /><br />-Jamie<br /><br /><br />----- Original Message -----<br />From: &quot;Prakash N&quot; &lt;<a target="_blank"  onclick\u003d\"return
 top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:nprakash@cedt.iisc.ernet.in\">nprakash@cedt.iisc.ernet.in</a>&gt;<br />To: &quot;Jamie Lin&quot; &lt;<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:jamiehl@mail.wsu.edu\">jamiehl@mail.wsu.edu</a>&gt;<br />Sent: Thursday, May 04, 2006 11:16 PM<br />Subject: RE: XILINX board-Audio Codec-Linux driver support<br /><br /><br />&gt; Jamie,<br />&gt; Could you please brief me how can I proceed in developing the<br />&gt; driver/adapter for linux-xilinx combination. Just give me some steps<br />&gt; for this audio support. Like, just outline what I need to do, then I<br />&gt; can proceed. I feel I may have to modify/add xilinx hardware related<br />&gt; stuff to AC97 general linux drivers.<br />&gt; Please guide  me in this.<br />&gt; Sincerely,<br />&gt; Prakash<br />&gt;<br />&gt; -----Original Message-----<br />&gt; From: Jamie Lin [mailto:<a target="_blank" 
 onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:jamiehl@mail.wsu.edu\">jamiehl@mail.wsu.edu</a>]<br />&gt; Sent: Monday, May 01, 2006 10:25 PM<br />&gt; To: Prakash N<br />&gt; Subject: Re: XILINX board-Audio Codec-Linux driver support<br />&gt;<br />&gt;<br />&gt; No, you can\'t just use these files under Linux. Xilinx has its way of<br />",1] );  //--> <br>Sorry about the delay. I was out of town for a while.<br>If you track down  Xilinx device driver functions, you'll<br>see that they use their own IO  functions. These functions<br>are specific to Xilinx products, and so they can't  be used directly<br>under Linux. The memory mapped IO driver I wrote can be used  to<br>replace these functions. You basically create a character device  on<br>your own, so that the device can be read/write in Linux.  I assume  you<br>have a good<br>programming knowledge, so just look into the  AC97<br>device driver, and track down to the lowest level
 IO.<br>From there, use  the Linux IO driver to replace these functions. I hope<br>this  helps.<br><br>-Jamie<br><br><br>----- Original Message -----<br>From: "Prakash  N" &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=nprakash@cedt.iisc.ernet.in">nprakash@cedt.iisc.ernet.in</a>&gt;<br>To:  "Jamie Lin" &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=jamiehl@mail.wsu.edu">jamiehl@mail.wsu.edu</a>&gt;<br>Sent:  Thursday, May 04, 2006 11:16 PM<br>Subject: RE: XILINX board-Audio Codec-Linux  driver support<br><br><br>&gt; Jamie,<br>&gt; Could you please brief me how can  I proceed in developing the<br>&gt; driver/adapter for linux-xilinx combination.  Just give me some steps<br>&gt; for this audio support. Like, just outline what  I need to do, then I<br>&gt; can proceed. I feel I may have  to modify/add xilinx  hardware related<br>&gt; stuff to AC97 general linux
 drivers.<br>&gt; Please  guide me in this.<br>&gt; Sincerely,<br>&gt; Prakash<br>&gt;<br>&gt;  -----Original Message-----<br>&gt; From: Jamie Lin [mailto:<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=jamiehl@mail.wsu.edu">jamiehl@mail.wsu.edu</a>]<br>&gt; Sent:  Monday, May 01, 2006 10:25 PM<br>&gt; To: Prakash N<br>&gt; Subject: Re: XILINX  board-Audio Codec-Linux driver support<br>&gt;<br>&gt;<br>&gt; No, you can't  just use these files under Linux. Xilinx has its way of<br> <cursive><!-- D(["mb","&gt; making device drivers to adapt their platforms. The Makefiles can only<br />&gt; be used to make Xilinx drivers. All drivers in EDK only work under<br />&gt; specific Xilinx platforms. That\'s why when we want to run Ethernet in<br />&gt; Linux, we need to copy BSP to Linux, so that it knows a specific type<br />&gt; of Ethernet needs to be made. We only replace files that  comes with<br />&gt; BSP in Linux. The rest of
 driver files in Linux are used to adapt the<br />&gt; device. If mv_linux BSP doesn\'t generate the device drivers for some<br />&gt; of your devices in the base system, it means that device is not<br />&gt; supported under Linux. To conclude, you need to write a custom AC97<br />&gt; adapter in order to make it work in Linux.<br />&gt;<br />&gt; -Jamie<br />&gt;<br />&gt;<br />&gt; ----- Original Message -----<br />&gt; From: &quot;Prakash N&quot; &lt;<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:nprakash@cedt.iisc.ernet.in\">nprakash@cedt.iisc.ernet.in</a>&gt;<br />&gt; To: &quot;Jamie Lin&quot; &lt;<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:jamiehl@mail.wsu.edu\">jamiehl@mail.wsu.edu</a>&gt;<br />&gt; Sent: Sunday, April 30, 2006 11:58 PM<br />&gt; Subject: RE: XILINX board-Audio Codec-Linux driver support<br />&gt;<br />&gt;<br />&gt; &gt;  Jamie,<br />&gt;
 &gt; Iam confused with bsp folders. I just updated EDK with this,<br />&gt; &gt; <a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"http://www.xilinx.com/univ/XUPV2P/lib/lib_rev_1_1.zip\" \u003d_blank>http://www.xilinx.com/univ<wbr />/XUPV2P/lib/lib_rev_1_1.zip</a><br />&gt; &gt; In that I could see EDK\\sw\\XilinxProcessorIPLib<wbr />\\drivers\\ac97_v2_00_a<br />&gt; &gt; having data and src dirs which contains,<br />&gt; &gt; Data --&gt; ac97_v2_1_0.tcl, ac97_v2_1_0.mdd<br />&gt; &gt; Src --&gt; xac97_l.h ,xac97_l.c , Makefile<br />&gt; &gt; Is it not possible to use these drivers, by copying and pasting in<br />&gt; &gt; EDK\\sw\\ThirdParty\\bsp\\linux<wbr />_mvl31_v1_01_a\\drivers<br />",1] );  //--> &gt; making device drivers to adapt their platforms. The Makefiles can  only<br>&gt; be used to make Xilinx drivers. All drivers in EDK only work  under<br>&gt; specific Xilinx platforms. That's why when we want to  run Ethernet 
 in<br>&gt; Linux, we need to copy BSP to Linux, so that it knows a specific  type<br>&gt; of Ethernet needs to be made. We only replace files that comes  with<br>&gt; BSP in Linux. The rest of driver files in Linux are used to adapt  the<br>&gt; device. If mv_linux BSP doesn't generate the device drivers for  some<br>&gt; of your devices in the base system, it means that device is  not<br>&gt; supported under Linux. To conclude, you need to write a custom  AC97<br>&gt; adapter in order to make it work in Linux.<br>&gt;<br>&gt;  -Jamie<br>&gt;<br>&gt;<br>&gt; ----- Original Message -----<br>&gt; From:  "Prakash N" &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=nprakash@cedt.iisc.ernet.in">nprakash@cedt.iisc.ernet.in</a>&gt;<br>&gt;  To: "Jamie Lin" &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=jamiehl@mail.wsu.edu">jamiehl@mail.wsu.edu</a>&gt;<br>&gt; Sent:  Sunday, April
 30, 2006 11:58 PM<br>&gt;  Subject: RE: XILINX board-Audio  Codec-Linux driver support<br>&gt;<br>&gt;<br>&gt; &gt; Jamie,<br>&gt; &gt; Iam  confused with bsp folders. I just updated EDK with this,<br>&gt; &gt; <a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="http://www.xilinx.com/univ/XUPV2P/lib/lib_rev_1_1.zip">http://www.xilinx.com/univ<wbr>/XUPV2P/lib/lib_rev_1_1.zip</a><br>&gt;  &gt; In that I could see  EDK\sw\XilinxProcessorIPLib<wbr>\drivers\ac97_v2_00_a<br>&gt; &gt; having data  and src dirs which contains,<br>&gt; &gt; Data --&gt; ac97_v2_1_0.tcl,  ac97_v2_1_0.mdd<br>&gt; &gt; Src --&gt; xac97_l.h ,xac97_l.c , Makefile<br>&gt;  &gt; Is it not possible to use these drivers, by copying and pasting in<br>&gt;  &gt; EDK\sw\ThirdParty\bsp\linux<wbr>_mvl31_v1_01_a\drivers<br> <cursive><!-- D(["mb","&gt; &gt; and run libgen .....<br />&gt; &gt; Please clarify,<br />&gt; &gt; Prakash<br />&gt; &gt;<br />&gt; &gt;<br />&gt; &gt;
 -----Original Message-----<br />&gt;  &gt; From: Jamie Lin [mailto:<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:jamiehl@mail.wsu.edu\">jamiehl@mail.wsu.edu</a>]<br />&gt; &gt; Sent: Monday, May 01, 2006 9:49 AM<br />&gt; &gt; To: Prakash N<br />&gt; &gt; Subject: Re: XILINX board-Audio Codec-Linux driver support<br />&gt; &gt;<br />&gt; &gt;<br />&gt; &gt; Prakash,<br />&gt; &gt;<br />&gt; &gt; The BSP only offers a limit number of necessary drivers. You\'ll have<br />&gt; &gt; to write custom drivers on your own if they\'re not included. One thing<br />&gt;<br />&gt; &gt; you can do is to use the sample IO driver I\'ve written to replace<br />&gt; &gt; low<br />&gt; &gt; level IOs in the Xilinx AC97 codec driver. This will take you some<br />&gt; &gt; time, but is a way to adapt AC97 codec in Linux that I can think of.<br />&gt; &gt; Other than this approach, I haven\'t seen any ready to use driver for<br />&gt; &gt;
 this codec.<br />&gt; &gt;<br />&gt; &gt; -Jamie<br  />&gt; &gt;<br />&gt; &gt;<br />&gt; &gt; ----- Original Message -----<br />&gt; &gt; From: &lt;<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:nprakash@cedt.iisc.ernet.in\">nprakash@cedt.iisc.ernet.in</a>&gt;<br />&gt; &gt; To: &lt;<a target="_blank"  onclick\u003d\"return top.js.OpenExtLink(window,event,this)\" href\u003d\"mailto:jamiehl@mail.wsu.edu\">jamiehl@mail.wsu.edu</a>&gt;<br />&gt; &gt; Sent: Friday, April 28, 2006 5:23 AM<br />&gt; &gt; Subject: XILINX board-Audio Codec-Linux driver support<br />&gt; &gt;<br />&gt; &gt;<br />&gt; &gt; &gt; Jamie Lin,<br />&gt; &gt; &gt; I could follow your doc and successfully ported the Linux in the<br />&gt; &gt; &gt; board. I<br />&gt; &gt; just<br />&gt; &gt; &gt; want to know how can I add the audio codec drivers in linux. I<br />&gt; &gt; &gt; mean,<br />&gt;<br />&gt; &gt; &gt; I<br />&gt; &gt; couldnt<br />&gt; &gt;
 &gt; see the Audio Codec in &quot;Connected Peripherals&quot; in Library &amp; OS<br  />",1] );  //--> &gt; &gt; and run libgen .....<br>&gt; &gt; Please clarify,<br>&gt; &gt;  Prakash<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; -----Original  Message-----<br>&gt; &gt; From: Jamie Lin [mailto:<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=jamiehl@mail.wsu.edu">jamiehl@mail.wsu.edu</a>]<br>&gt; &gt; Sent:  Monday, May 01, 2006 9:49 AM<br>&gt; &gt; To: Prakash N<br>&gt; &gt; Subject:  Re: XILINX board-Audio Codec-Linux driver support<br>&gt; &gt;<br>&gt;  &gt;<br>&gt; &gt; Prakash,<br>&gt; &gt;<br>&gt; &gt; The BSP only offers a limit  number of necessary drivers. You'll have<br>&gt; &gt; to write custom drivers on  your own if they're not included. One thing<br>&gt;<br>&gt; &gt; you can do is  to use the sample IO driver I've written to replace<br>&gt; &gt; low<br>&gt;  &gt; level IOs in the Xilinx AC97 codec driver. This will take
 you some<br>&gt;  &gt; time, but is a way to adapt AC97 codec in Linux that I can think  of.<br>&gt;  &gt; Other than this approach, I haven't seen any ready to use  driver for<br>&gt; &gt; this codec.<br>&gt; &gt;<br>&gt; &gt; -Jamie<br>&gt;  &gt;<br>&gt; &gt;<br>&gt; &gt; ----- Original Message -----<br>&gt; &gt; From:  &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=nprakash@cedt.iisc.ernet.in">nprakash@cedt.iisc.ernet.in</a>&gt;<br>&gt;  &gt; To: &lt;<a target="_blank" onfiltered="return top.js.OpenExtLink(window,event,this)" href="Compose?To=jamiehl@mail.wsu.edu">jamiehl@mail.wsu.edu</a>&gt;<br>&gt; &gt;  Sent: Friday, April 28, 2006 5:23 AM<br>&gt; &gt; Subject: XILINX board-Audio  Codec-Linux driver support<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; &gt; Jamie  Lin,<br>&gt; &gt; &gt; I could follow your doc and successfully ported the Linux  in the<br>&gt; &gt; &gt; board. I<br>&gt; &gt; just<br>&gt; &gt; &gt; want to 
 know how can I add the audio codec drivers in linux. I<br>&gt; &gt; &gt;  mean,<br>&gt;<br>&gt; &gt; &gt; I<br>&gt; &gt; couldnt<br>&gt; &gt; &gt;  see the  Audio Codec in "Connected Peripherals" in Library &amp; OS<br> <cursive><!-- D(["mb","&gt; &gt; &gt; parameters (software platform settings). But in the hardware I could<br />&gt;<br />&gt; &gt; &gt; see its there<br />&gt; &gt; with<br />&gt; &gt; &gt; all version, base address... defined. How can I add this in that<br />&gt; &gt; &gt; so<br />&gt; &gt; &gt; that<br />&gt; &gt; thro\'<br />&gt; &gt; &gt; libgen I can add drivers for that also.<br />&gt; &gt; &gt; Regards<br />&gt; &gt; &gt; Prakash<br /><br />------------------------------<wbr />------------------------------<wbr />------------------------------<wbr />------------------------------<br /><br />I feel I\'d given whatever possible details, still If something is<br />missing, Please ask the same.<br />Prakash<br /></div>",1] ); D(["mb","<div
 style\u003d\"direction:ltr\" ><span class\u003dsg><br /><br /><br />--<br />N.Prakash<br />Bangalore<br />+919448787632<br /><br /></span></div>",0] );  D(["ma",[1,"<table class\u003datt cellspacing\u003d0 cellpadding\u003d5 border\u003d0><tr><td colspan\u003d2><b style\u003dpadding-left:3>2 attachments</b> — Scanning for viruses...<tr><td><table cellspacing\u003d0 cellpadding\u003d0><tr><td><img width\u003d16 height\u003d16 src\u003d\"/mail/images/zip.gif\"><td width\u003d7><td><b>temp.zip</b><br>294K </table><tr><td><table cellspacing\u003d0 cellpadding\u003d0><tr><td><img width\u003d16 height\u003d16 src\u003d\"/mail/images/zip.gif\"><td width\u003d7><td><b>linuxaudio.zip</b><br>22K </table></table>","10bd14d0c40a4b1e"] ] );  //--> &gt; &gt; &gt; parameters (software platform settings). But in the hardware I  could<br>&gt;<br>&gt; &gt; &gt; see its there<br>&gt; &gt; with<br>&gt; &gt;  &gt; all version, base address... defined. How can I add this in that<br>&gt;  &gt;
 &gt; so<br>&gt; &gt; &gt; that<br>&gt; &gt; thro'<br>&gt; &gt; &gt; libgen  I can add drivers for that also.<br>&gt; &gt; &gt; Regards<br>&gt;  &gt; &gt;  Prakash<br><br>------------------------------<wbr>------------------------------<wbr>------------------------------<wbr>---------<br><br>I  feel I'd given whatever possible details, still If something is<br>missing,  Please ask the same.<br>N.Prakash<br>ME Final Year- Microelectronics<br>CEDT-IISc<br>Bangalore<br>India</cursive></cursive></cursive></cursive></div> <p>&#32;
	

	
		<hr size=1></hr> 
 Yahoo! India Answers: Share what you know. Learn something new <a href="http://us.rd.yahoo.com/mail/in/mailanswersshare/*http://in.answers.yahoo.com/">Click here</a><br> 
Send free SMS to your Friends on Mobile from your Yahoo! Messenger <a href="http://us.rd.yahoo.com/mail/in/freesms/*http://messenger.yahoo.com/download.php">Download now</a>
--0-75631034-1150692564=:95530--
