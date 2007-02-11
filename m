Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s31.bay0.hotmail.com (bay0-omc3-s31.bay0.hotmail.com
	[65.54.246.231]) by ozlabs.org (Postfix) with ESMTP id 53FB6DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Feb 2007 00:37:19 +1100 (EST)
Message-ID: <BAY110-F2669499909689C5DC2B93B2920@phx.gbl>
In-Reply-To: <20070209160123.BFF2BA30080@mail83-dub.bigfish.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Rick.Moleres@xilinx.com
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Sun, 11 Feb 2007 13:37:11 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Rick,
First thank you SO SO SO MUCH for your kindly telling. It's really useful 
for me to solve problems.

>From the test summary listed, I can see that we have similar systems except 
that you are using MontaVista while I am using the general open-source 
kernel. Also I enabled all the features which could improve the 
performance, including DRE, CSUM offload and SGDMA,etc. 

>- Are Checksum offload, SGDMA, and DRE enabled in the plb_temac?
Yes. All features are enabled.

>- Are you using the TCP_SENDFILE option of netperf?  Your UDP numbers are 
similar already to what we saw in Linux 2.6, and your TCP numbers are 
similar to what we saw *without* the sendfile option.

Perhaps no. I just understand that sendfile option is so important to 
improve performance. At first I thought it will achieve a same performance 
with TCP_STREAM, until I saw the article to explain how to use sendfile() 
to optimize data transfer. So I will try this soon. 

After some reading of the articles on performance improving, here come 
other problems. So I will appreciate you so much if you can clarify them 
for me. 

>1. Results are from PLB_TEMAC, not GSRD.  You would likely see similar 
throughput rates with GSRD and Linux.

Problem 1: From the website for GSRD, I know that it uses a different 
structure than PLB, where a Multi port mem controller and DMA are added to 
release the CPU from move data between Memory and TEMAC. So can GSRD 
achieve a higher performance than PLB_TEMAC, or similar performance like 
what you said above? If their performance is similar, what's the advantage 
for GSRD? Could you please explain some differences between these two 
structures? 

>2. Assuming you have everything tuned for SGDMA based on previous emails, 
I would suspect the bottleneck is the 300MHz CPU *when* running Linux.  In 
Linux 2.6 we've not spent any time trying to tune the TCP/Ethernet 
parameters on the target board or the host, so there could be some 
optimizations that can be done at that level.  In the exact same system we 
can achieve over 800Mbps using the Treck TCP/IP stack, and with VxWorks it 
was over 600Mbps.  

Problem 2. I read XAPP546 of High performance TCP/IP on xilinx FPGA devices 
using the Treck embedded TCP/IP stack. I notice that the features of Treck 
TCP/IP stack include: Zero-copy send and receive, Jumbo-frame support, CSUM 
offload, etc. which could achieve a much higher performance than not using 
it. However in the Xilinx TEMAC core V3.00, these features are all 
supported: Zero-copy is supported by sendfile() when using Netperf; 
Jumbo-frame is also supported; CSUM offload and DRE are also supported by 
the hardware. So does this mean I can achieve a similarly high performance 
with PLB_TEMAC V3.00 and without Treck TCP/IP stack? I mean if all the 
features of Treck stack have been included in the PLB_TEMAC cores, what's 
the use for Treck stack? 

Maybe my questions are a little stupid. But I am really confused on them. 
So thank you so much if you can explain them to me. Thanks a lot.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
