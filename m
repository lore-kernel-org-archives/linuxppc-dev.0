Return-Path: <bhupi.saharan@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id 23640DDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 21:52:52 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so870822wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 04:52:51 -0700 (PDT)
Message-ID: <720399a30706250452m4f04f6e6w1f0fdb4b0da76b12@mail.gmail.com>
Date: Mon, 25 Jun 2007 04:52:50 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: ML403 gigabit ethernet bandwidth - 2.6 kernel
In-Reply-To: <BAY115-W1188529D49F71948165AF6B2160@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_153_12213300.1182772370337"
References: <BAY115-W1188529D49F71948165AF6B2160@phx.gbl>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_153_12213300.1182772370337
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We need to findout where is the bottlenect.

1. Run vmstat on the ML403 board and find out the percentage CPU is busy
when you are transferring the file. That will show if cpu is busy or not.
2. Run oprofile and find out which are the routines eating away the cpu
time.

Once we have data from both the above routines, we can find out the
bottlenecks.


Regards
Bhupi


On 6/23/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
>
> Dear all,
>
> Recently we did a set of tests on performance of virtex 4FX hard TEMAC
> module using ML403
>
> we studied all of the posts here carefully: these are the system
> characteristics;
>
> Board : ML403
> EDK    : EDK9.1SP2
> Hard TEMAC version and PLTEMAC version are both 3.0.a
> PPC clock frequency :  300MHz
> Kernel : 2.6.21-rc7 , downloaded from grant's git tree some thing near one
> week ago
> DMA type: 3 (sg dma)
> DRE : enabled for TX and RX, (2)
> CSUM offload is enabled for both of TX and RX
> tx and rx fifo sizes : 131072 bits
>
> the board comes up over NFS root file system completely and without any
> problems.
>
> PC system used for these tests is : CPU P4 Dual Core, 3.4GHz , 2Gigabytes
> memory, Dual gigabit ethernet port, running linux 2.6.21.3
> We have tested the PC system band width and it can easily reach 966mbits/s
> when connected to the same PC. ( using the same cross cable used for ml403
> test)
>
> Netperf is compiled with TCP SEND FILE enabled, ( -DHAVE_SENDFILE)
>
> (from board to PC)
> netperf -t TCP_SENDFILE -H 10.10.10.250 -F /boot/zImage.elf -- -m 16384 -s
> 87380 -S 87380
>
> the measured bandwidth for this test was just 40.66Mbits.
> It is also true for netperf from PC to board.
>
> we do not have any more idea about what we should do to improve the
> bandwidth.
> any help or ideas is appreciated...
>
> _________________________________________________________________
> Connect to the next generation of MSN Messenger
>
> http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_153_12213300.1182772370337
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>We need to findout where is the bottlenect.<br><br>1. Run vmstat on the ML403 board and find out the percentage CPU is busy when you are transferring the file. That will show if cpu is busy or not.<br>2. Run oprofile and find out which are the routines eating away the cpu time.
<br><br>Once we have data from both the above routines, we can find out the bottlenecks.<br><br><br>Regards<br>Bhupi<br><br><br><div><span class="gmail_quote">On 6/23/07, <b class="gmail_sendername">Mohammad Sadegh Sadri</b>
 &lt;<a href="mailto:mamsadegh@hotmail.com">mamsadegh@hotmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Dear all,
<br><br>Recently we did a set of tests on performance of virtex 4FX hard TEMAC module using ML403<br><br>we studied all of the posts here carefully: these are the system characteristics;<br><br>Board : ML403<br>EDK&nbsp;&nbsp;&nbsp;&nbsp;: EDK9.1SP2
<br>Hard TEMAC version and PLTEMAC version are both 3.0.a<br>PPC clock frequency :&nbsp;&nbsp;300MHz<br>Kernel : 2.6.21-rc7 , downloaded from grant&#39;s git tree some thing near one week ago<br>DMA type: 3 (sg dma)<br>DRE : enabled for TX and RX, (2)
<br>CSUM offload is enabled for both of TX and RX<br>tx and rx fifo sizes : 131072 bits<br><br>the board comes up over NFS root file system completely and without any problems.<br><br>PC system used for these tests is : CPU P4 Dual Core, 
3.4GHz , 2Gigabytes memory, Dual gigabit ethernet port, running linux <a href="http://2.6.21.3">2.6.21.3</a><br>We have tested the PC system band width and it can easily reach 966mbits/s when connected to the same PC. ( using the same cross cable used for ml403 test)
<br><br>Netperf is compiled with TCP SEND FILE enabled, ( -DHAVE_SENDFILE)<br><br>(from board to PC)<br>netperf -t TCP_SENDFILE -H <a href="http://10.10.10.250">10.10.10.250</a> -F /boot/zImage.elf -- -m 16384 -s 87380 -S 87380
<br><br>the measured bandwidth for this test was just 40.66Mbits.<br>It is also true for netperf from PC to board.<br><br>we do not have any more idea about what we should do to improve the bandwidth.<br>any help or ideas is appreciated...
<br><br>_________________________________________________________________<br>Connect to the next generation of MSN Messenger<br><a href="http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&amp;source=wlmailtagline">
http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&amp;source=wlmailtagline</a><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_153_12213300.1182772370337--
