Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EA1DDB6F70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 08:41:38 +1100 (EST)
Message-ID: <4ED3FFFC.50807@freescale.com>
Date: Mon, 28 Nov 2011 15:41:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
 <1321349355-1639-3-git-send-email-b35362@freescale.com>
 <4ECC368C.3010801@freescale.com> <4ECCE393.2030600@freescale.com>
In-Reply-To: <4ECCE393.2030600@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Liu Shuo <Shuo.Liu@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2011 06:14 AM, LiuShuo wrote:
> =E4=BA=8E 2011=E5=B9=B411=E6=9C=8823=E6=97=A5 07:55, Scott Wood =E5=86=99=
=E9=81=93:
>> On 11/15/2011 03:29 AM, b35362@freescale.com wrote:
>>> From: Liu Shuo<b35362@freescale.com>
>>>
>>> -        if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column !=3D 0 ||
>>> +        if (elbc_fcm_ctrl->column>=3D mtd->writesize) {
>>> +            /* write oob */
>>> +            if (priv->page_size>  1) {
>>> +                /* when pagesize of chip is greater than 2048,
>>> +                 * we have to write full page to write spare
>>> +                 * region, so we fill '0xff' to main region
>>> +                 * and some bytes of spare region which we
>>> +                 * don't want to rewrite.
>>> +                 * (write '1' won't change the original value)
>>> +                 */
>>> +                memset(elbc_fcm_ctrl->buffer, 0xff,
>>> +                        elbc_fcm_ctrl->column);
>> I don't like relying on this -- can we use RNDIN instead to do a
>> discontiguous write?
>>
> I have no better way to implement it now.
> Some chips have 'NOP' limitation, so I don't use the FIR_OP_UA to do a
> oob write.

I don't think each RNDIN counts separately against NOP (someone correct
me if I'm wrong).  You're writing discontiguous regions of the page in
one operation.

-Scott
