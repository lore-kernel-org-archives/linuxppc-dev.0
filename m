Return-Path: <blofeldus@yahoo.com>
Received: from web53506.mail.yahoo.com (web53506.mail.yahoo.com
	[206.190.37.67]) by ozlabs.org (Postfix) with SMTP id 2CE912BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 04:48:43 +1100 (EST)
Message-ID: <20041129174842.14784.qmail@web53506.mail.yahoo.com>
Date: Mon, 29 Nov 2004 09:48:42 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: tnt@246tNt.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: MPC5200 Cache coherency with BestComm issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Hi Roger
>
>> By experimenting I have found that the BestComm and FEC work without
>>the cache flush provided CPU_FTR_MAYBE_CAN_NAP is removed from the
>>cputable (nap disables snooping) and that CPU_FTR_NEED_COHERENT is
>>added to the cputable (turns on "M" bit in BAT/PTE so that the XLB
has
>>a chance of seeing a global transaction).
>>  
>>
>Thanks for the info.
>
>The nap thing was indeed obvious ... The proper way to deactivate it 
>would be in lite5200.c
>I added the powersave_nap = 1; as an example on how to allow it to
nap. 
>I'll probably comment it out by default with a note.
>
>For the CPU_FTR_NEED_COHERENT, are you sure it's required ?
 >From my understanding of the G2Core manual, the M bit must be set if 
>you want the G2Core
>to assert the global signal when it access memory. Here, we don't care

>since only the G2Core is snooping on the bus. So that should not be
required ...
>
>
>    Sylvain

Sylvain,
 You are correct. The CPU_FTR_NEED_COHERENT is not required. Perhaps
the solution is to only turn on powersave_nap if CONFIG_PPC_BESTCOMM is
not selected.
-rb




		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
