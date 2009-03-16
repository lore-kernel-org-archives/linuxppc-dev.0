Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74682DDED5
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 23:42:28 +1100 (EST)
Message-Id: <7D7326A0-B3F2-4E85-8A6B-B003A7B3F009@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1E3E0E6E-39A6-4DC5-BB38-0C66D96C9C75@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH v3] powerpc: e300c2/c3/c4 TLB errata workaround
Date: Mon, 16 Mar 2009 07:42:12 -0500
References: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
	<1236979602.25062.55.camel@pasglop>
	<1E3E0E6E-39A6-4DC5-BB38-0C66D96C9C75@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	David Jander <david.jander@protonic.nl>, Wolfgang Denk <wd@denx.de>,
	Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2009, at 5:06 PM, Kumar Gala wrote:

>
> On Mar 13, 2009, at 4:26 PM, Benjamin Herrenschmidt wrote:
>
>>> +BEGIN_FTR_SECTION
>>> +	b      TlbWo    /* Code for TLB-errata workaround doesn't fit  
>>> here */
>>> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_DTLB_SW_LRU)
>>> +RFTlbWo:
>>
>> Can you use nicer label names ? :-)
>>
>> Also, that's a lot of code for such a hot path...
>>
>> Cheers,
>> Ben.
>
> The code needs reworking.  However, we are doing SW LRU, not sure  
> how we reduce this in the hot path.

Ben, David,

Here's my attempt at reworking the code to use an SPRG, remove  
branches, optimize it down, etc.  I haven't validated that this is  
even correct.  It should be easy to replace the m{f,t}spr SPRG w/lwz/ 
stw if we want to keep the LRU state in memory instead.

Ben, do you think we can optimize this further with some random LRU  
selection?

         mtspr   SPRN_RPA,r1
         mfspr   r2,SPRN_SRR1            /* Need to restore CR0 */
         mtcrf   0x80,r2
#if 1
         li      r0,1
	mfspr	r1,SPRN_SPRG4		/* could replace w/lwz	r1,sw_way_lru@l(0) */
         rlwinm  r3,r3,19,25,29          /* Get Address bits 19:15 */
         slw     r0,r0,r3
         xor     r1,r0,r1
         srw     r0,r1,r3
	mtspr	SPRN_SPRG4,r1		/* could replace w/stw	r1,sw_way_lru@l(0) */
         rlwimi  r2,r0,31-14,14,14
#endif
         tlbld   r3
         rfi
