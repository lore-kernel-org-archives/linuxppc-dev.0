Message-ID: <3E3E6086.6000209@intracom.gr>
Date: Mon, 03 Feb 2003 14:28:54 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 3
References: <IGEFJKJNHJDCBKALBJLLIENMFJAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLIENMFJAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>>This is the second version of my patch that removes the expensive memcpy of
>>>received
>>>ethernet frames in interrupt context.
>>>
>>>I have 1 report(from Ricardo Scop) of 20% increase in packets/second, packet
>>>size 1500 when
>>>applied to 8260 FEC(needs to be applied manually). But min packet size
>>>decreased with 10 %.
>>>This version should fix the 10% decrease case.
>>>
>>>This patch could be adapted 8xx_io/fec.c and 8260_io/enet.c and
>>>8260/fcc_enet.c with little effort.
>>>
>>>Better fix a bug in set_multicast_list(), move the dmi list forward when
>>>    walking it(dmi = dmi->next;)
>>>
>>>New stuff:
>>>   - Configrable: copy small packets or pass them directly, see
>>>COPY_SMALL_FRAMES in code.
>>>   - Collision reporting fix form Thomas Lange.
>>>   - Don't pass receive frames which has error upwards.
>>>   - Report RX_OV errors as fifo errors, not crc errors.
>>>
>>>Please test and report any problems and performace improvements.
>>>
>>>
>>Hi
>>
>>This is the third version of my optimized enet.c patch.
>>Changes since version 2:
>>  1) invalidate the whole buffer BEFORE it is given to he CPM. Previously
>>     it was invalidated after the packet was received and that could lead to buffer
>>     corruption in some cases.
>>
>>  2) use dma_cache_inv() instead of invalidate_dcache_range() since that will work
>>     for both 8xx and 82xx.
>>
>>  3) decrease the allocated buffer length.
>>
>>  4) disabled COPY_SMALL_FRAME. Define it somewhere if you want to save some memory.
>>
>>  5) probably some white space changes got in too.
>>
>>Any chance to see it the devel tree?
>>
>>More than 3 months has passed since version 2 and the only problem reported was
>>1) and the fix has been know since mid November.
>>
>>Dan, you said you would integrate this patch(or some version of it) in November. I
>>think I have waited long enough now. Please do ASAP.
>>
>> Jocke
>>
>>
>[SNIP]
>
>Zero feedback so far. Is there zero interest to improve the mpc code in linuxppc?
>Anyhow, I give up. Don't have the energy to resend over and over again.
>
>   Jocke
>
>
>
>
>
>
Please don't give up.

I'll try it and you'll have my feedback within the week.

Anyhow, what is the deal with 8xx/82xx?
At least the maintainers should ack the patch, and if it is not suitable
for inclusion they should state for what reason.

We don't want to discourage people sending patches.
Right?

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
