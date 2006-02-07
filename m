Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id C48F2689D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 01:18:52 +1100 (EST)
Message-ID: <43E8ACB3.6030401@compulab.co.il>
Date: Tue, 07 Feb 2006 16:20:35 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 USB driver & MPC8248
References: <200602031210.12603.laurent.pinchart@tbox.biz>
	<43E5BAE8.9000507@compulab.co.il>
	<200602071414.28551.laurent.pinchart@tbox.biz>
In-Reply-To: <200602071414.28551.laurent.pinchart@tbox.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Laurent Pinchart wrote:

>How is the driver development going ? You're not using the sourceforge CVS/SVN 
>repository, is there another one somewhere (maybe a git tree) ? Are you 
>actively working on performance issues, or is the development currently 
>stalled ? 
>  
>
The driver development is stalled and I don't know when I'll be able to 
continue working on it.

>What are the major performance issues ? 
>  
>
One of the issues in this driver is redunduncy between qe end ep 
structures and as a consequence a lot of uneeded code that make cross 
updates.
I didn't run profiling, so I can't tell better.

>I noticed that the driver uses the MPC82xx packet level interface. 
>Why don't you use the transaction level interface ?
>  
>
The original driver I've started with used packet level. I thought on 
switching to transaction level, but I hadn't time for it because of 
other projects pressure.

>  
>
>>Another thing that may cause problems is how storage devices treat SOF
>>packets, but I'm not USB expert enough to be sure about that.
>>    
>>
>
>That might explain why some devices don't even respond to the first request. I 
>noticed that, on my EP8248 board, the controller only sends 990 SOF packets 
>per second (or rather 990 SOF interrupts are generated). I might have a time 
>base problem somewhere, as I computed the number of interrupts per second 
>with a simple
>
>cat /proc/driver/m8xxhci_privateh > sof.1 && sleep 300 && 
>cat /proc/driver/m8xxhci_privateh > sof.2
>
>  
>
I'm not sure such measurements are correct, since you sleep not exatly 
300 seconds. I haven't measured how many SOF interrupts I get, but I 
think you maybe right.
It may happen that during transmit or recieve the interrupts are off and 
SOF packets are not sent.

>Do you have the same problem ? I'll see if I can get my hands on a USB 
>protocol analyzer.
>  
>
Good luck, I'll try to help but unfotunately I'm very much busy with 
other projects now.

>Laurent Pinchart
>
>
>
>  
>


-- 
Sincerely yours,
Mike Rapoport
