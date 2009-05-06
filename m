Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id A3A83DDFC6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:43:16 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so216925yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:43:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506221250.C977183420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-4-git-send-email-wd@denx.de>
	<fa686aa40905061337w6aa82f5aj787618ba108e528f@mail.gmail.com>
	<20090506221250.C977183420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:42:55 -0600
Message-ID: <fa686aa40905061542g2cf538bau5eebcfc154906810@mail.gmail.com>
Subject: Re: [PATCH 03/12] fs_enet: Add FEC TX Alignment workaround for
	MPC5121.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:12 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40905061337w6aa82f5aj787618ba108e528f@mail.gmail.com> =
you wrote:
>>
>> > The FEC on 5121 has problems with misaligned tx buffers.
>> > The RM says any alignment is ok but empirical results
>> > show that packet buffers ending in 0x1E will sometimes
>> > hang the FEC. Other bad alignment does not hang but will
>> > cause silent TX failures resulting in about a 1% packet
>> > loss as tested by ping -f from a remote host.
>> >
>> > This patch is a work around that copies every tx packet
>> > to an aligned skb before sending.
>>
>> OUCH!
>
> Yes :-(
>
>> > +#else
>> > +#define tx_skb_align_workaround(dev, skb) (skb)
>> > +#endif
>>
>> Another use of #ifdef blocks. =A0What is the multiplatform impact?
>
> Hm... Can you recommend a better way to solve the problem? Suggestions
> are welcome.

I'd rather see a runtime selectable workaround.  ie. enable it based
on the compatible property.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
