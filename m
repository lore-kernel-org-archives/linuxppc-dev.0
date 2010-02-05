Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185]) by ozlabs.org (Postfix) with ESMTP id 9A9E4B7BFA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 07:29:52 +1100 (EST)
Received: by yxe15 with SMTP id 15so5024426yxe.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Feb 2010 12:29:51 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B6C5271.9080802@cs.ucr.edu>
References: <4B6762CE.1050001@cs.ucr.edu>
	<fa686aa41002031501q14e8ab54s6713edc58d0fddc1@mail.gmail.com>
	<4B6C5271.9080802@cs.ucr.edu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 5 Feb 2010 12:29:31 -0800
Message-ID: <fa686aa41002051229y3c19ebfj9ae6d52811199668@mail.gmail.com>
Subject: Re: PATCH: Add non-Virtex 5 support for LL TEMAC driver
To: John Tyner <jtyner@cs.ucr.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 9:16 AM, John Tyner <jtyner@cs.ucr.edu> wrote:
>
>
> Grant Likely wrote:
>>
>> On Mon, Feb 1, 2010 at 4:25 PM, John Tyner <jtyner@cs.ucr.edu> wrote:
>>>
>>> This patch adds support for using the LL TEMAC Ethernet driver on
>>> non-Virtex
>>> 5 platforms by adding support for accessing the Soft DMA registers as i=
f
>>> they were memory mapped instead of solely through the DCR's (available =
on
>>> the Virtex 5).
>>>
>>> Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
>>
>> Hi John, thanks for doing this work. =A0A couple of comments below.
>>
>
> [snip]
>
>>> =A0* TODO:
>>> - * - Fix driver to work on more than just Virtex5. =A0Right now the dr=
iver
>>> - * =A0 assumes that the locallink DMA registers are accessed via DCR
>>> - * =A0 instructions.
>>> =A0* - Factor out locallink DMA code into separate driver
>>> =A0* - Fix multicast assignment.
>>> =A0* - Fix support for hardware checksumming.
>>> @@ -117,12 +114,20 @@
>>>
>>> =A0static u32 temac_dma_in32(struct temac_local *lp, int reg)
>>> =A0{
>>> - =A0 =A0 =A0 return dcr_read(lp->sdma_dcrs, reg);
>>> + =A0 =A0 =A0 if (lp->sdma_regs) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(lp->sdma_regs + reg);
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dcr_read(lp->sdma_dcrs, reg);
>>> + =A0 =A0 =A0 }
>>
>> Rather than taking the ugliness an if/else block on every register
>> access, why not create an ops structure and populate it with the
>> correct access routines at runtime?
>
> As you can see from the comments in the TODO section, someone thinks (and=
 I
> would tend to agree) that it would be a good idea to separate the DMA cod=
e
> from the Ethernet driver entirely. I also agree with your suggestion of
> avoiding the ugliness of the if/else block, but it seems like a job bette=
r
> left to be done when that refactoring takes place.
>
> This patch is only about 20 lines worth of changes, and to add a bunch of
> complexity doesn't seem worthwhile to me at this time.

I wrote that comment, so that someone would happen to be me.  :-)

Breaking the register access functions out into callbacks or an ops
callbacks structure is unrelated to the DMA refactoring task.  Doing
callbacks is pretty trivial to implement and it makes things simpler,
not more complex.

>
>>> @@ -895,7 +904,7 @@
>>>
>>> =A0 =A0 =A0 =A0lp->phy_node =3D of_parse_phandle(op->node, "phy-handle"=
, 0);
>>> =A0 =A0 =A0 =A0if (lp->phy_node)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(lp->dev, "using PHY node %s (%p)\=
n",
>>> np->full_name, np);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(lp->dev, "using PHY node %s (%p)\=
n",
>>> lp->phy_node->full_name, lp->phy_node);
>>
>> This looks like an unrelated bug fix. =A0Please put into a separate
>> patch and post separately.
>
> It is an unrelated bug fix. If it's really a big deal, I can submit a
> separate patch, but it seems like it would be easier for someone to manua=
lly
> make this change than for me to go back and generate a new patch (since I=
'm
> not working on anything related to this anymore).
>
> I apologize for being kind of a dick about this stuff, but as I said, I'm
> not doing anything related to this stuff anymore. The change is really
> small, but adds support for something that currently doesn't work, so I'm
> hoping somebody else is willing to take up the cause in my stead. :)

Fair enough.  Thanks for posting what you have.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
