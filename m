Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414hYB30xtzF45j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 17:37:17 +1000 (AEST)
Received: by mail-pf0-x22e.google.com with SMTP id y8-v6so2570115pfm.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:37:17 -0700 (PDT)
Received: from [192.168.1.11] (14-202-194-140.static.tpgi.com.au.
 [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id k80-v6sm1351045pfa.168.2018.06.12.00.37.10
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Jun 2018 00:37:14 -0700 (PDT)
Subject: Re: 4.17.0-10146-gf0dc7f9c6dd9: hw csum failure on powerpc+sungem
To: linuxppc-dev@lists.ozlabs.org
References: <alpine.LRH.2.21.1806111352330.17091@math.ut.ee>
 <CA+7wUsw_8znPDsej=j48kkmqV3vPbOuDociBE4tth53-Zj32qA@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4030b744-f99c-bdfc-5f95-c9311e31ad0c@gmail.com>
Date: Tue, 12 Jun 2018 17:37:07 +1000
MIME-Version: 1.0
In-Reply-To: <CA+7wUsw_8znPDsej=j48kkmqV3vPbOuDociBE4tth53-Zj32qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12/06/18 06:20, Mathieu Malaterre wrote:

> Hi Meelis,
>
> On Mon, Jun 11, 2018 at 1:21 PM Meelis Roos <mroos@linux.ee> wrote:
>> I am seeing this on PowerMac G4 with sungem ethernet driver. 4.17 was
>> OK, 4.17.0-10146-gf0dc7f9c6dd9 is problematic.
> Same here.
>
>> [  140.518664] eth0: hw csum failure
>> [  140.518699] CPU: 0 PID: 1237 Comm: postconf Not tainted 4.17.0-10146-gf0dc7f9c6dd9 #83
>> [  140.518707] Call Trace:
>> [  140.518734] [effefd90] [c03d6db8] __skb_checksum_complete+0xd8/0xdc (unreliable)
>> [  140.518759] [effefdb0] [c04c1284] icmpv6_rcv+0x248/0x4ec
>> [  140.518775] [effefdd0] [c049a448] ip6_input_finish.constprop.0+0x11c/0x5f4
>> [  140.518786] [effefe10] [c049b1c0] ip6_mc_input+0xcc/0x100
>> [  140.518807] [effefe20] [c03e110c] __netif_receive_skb_core+0x310/0x944
>> [  140.518820] [effefe70] [c03e76ec] napi_gro_receive+0xd0/0xe8
>> [  140.518845] [effefe80] [f3e1f66c] gem_poll+0x618/0x1274 [sungem]
>> [  140.518856] [effeff30] [c03e6f0c] net_rx_action+0x198/0x374
>> [  140.518872] [effeff90] [c0501a88] __do_softirq+0x120/0x278
>> [  140.518890] [effeffe0] [c0036188] irq_exit+0xd8/0xdc
>> [  140.518908] [effefff0] [c000f478] call_do_irq+0x24/0x3c
>> [  140.518925] [d05a5d30] [c0007120] do_IRQ+0x74/0xf0
>> [  140.518941] [d05a5d50] [c0012474] ret_from_except+0x0/0x14
>> [  140.518960] --- interrupt: 501 at copy_page+0x40/0x90
>>                    LR = copy_user_page+0x18/0x30
>> [  140.518973] [d05a5e10] [d058cd80] 0xd058cd80 (unreliable)
>> [  140.518989] [d05a5e20] [c00fa2bc] wp_page_copy+0xec/0x654
>> [  140.519002] [d05a5e60] [c00fd3a4] do_wp_page+0xa8/0x5b4
>> [  140.519013] [d05a5e90] [c00fe934] handle_mm_fault+0x564/0xa84
>> [  140.519025] [d05a5f00] [c0016230] do_page_fault+0x1bc/0x7e8
>> [  140.519037] [d05a5f40] [c0012300] handle_page_fault+0x14/0x40
>> [  140.519048] --- interrupt: 301 at 0xb78b6864
>>                    LR = 0xb78b6c54
>>
> For some reason if I do a git bisect it returns that:
>
> $ git bisect good
> 3036bc45364f98515a2c446d7fac2c34dcfbeff4 is the first bad commit
>
> Could you also check on your side please.

Don't have a G4, but the related commits look like

373e098e1e788d7b89ec0f31765a6c08e2ea0f7c and e9c4943a107b56696e4872cdffdba6b0c7277c77 Balbir
