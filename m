Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EB02BDDDE3
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 09:03:53 +1100 (EST)
Date: Mon, 20 Oct 2008 02:03:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Add the of_find_i2c_device_by_node function
Message-ID: <20081019220352.GA19539@oksana.dev.rtsoft.ru>
References: <20081019140040.32281.65209.stgit@terra>
	<20081019212034.GA8224@oksana.dev.rtsoft.ru>
	<9e4733910810191450t36cbe120y106d18f71cb3163b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910810191450t36cbe120y106d18f71cb3163b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 19, 2008 at 05:50:15PM -0400, Jon Smirl wrote:
> On Sun, Oct 19, 2008 at 5:20 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Hi Jon,
> >
> > On Sun, Oct 19, 2008 at 10:00:40AM -0400, Jon Smirl wrote:
> >> Add the of_find_i2c_device_by_node function. This allows you to follow
> >> a reference in the device tree to an i2c device node and then locate
> >> the linux device instantiated by the device tree. Example use, an i2s
> >> codec controlled by i2c. Depends on patch exporting i2c root bus symbol.
> >>
> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> >
> > Few comments are below.
> >
> >> ---
> >>  drivers/of/of_i2c.c |   28 ++++++++++++++++++++++++----
> >>  1 files changed, 24 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> >> index 6a98dc8..ba7b394 100644
> >> --- a/drivers/of/of_i2c.c
> >> +++ b/drivers/of/of_i2c.c
> >> @@ -19,7 +19,7 @@
> >>  void of_register_i2c_devices(struct i2c_adapter *adap,
> >>                            struct device_node *adap_node)
> >>  {
> >> -     void *result;
> >> +     struct i2c_client *i2c_dev;
> >>       struct device_node *node;
> >>
> >>       for_each_child_of_node(adap_node, node) {
> >> @@ -41,18 +41,38 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >>
> >>               info.addr = *addr;
> >>
> >> -             request_module(info.type);
> >> +             request_module("%s", info.type);
> >
> > Patch description doesn't mention this change.
> 
> Patches for this have been posted before by other people and they
> aren't making it in.
> 
> This is the original mail....
> http://lkml.org/lkml/2008/6/13/290
> http://lkml.org/lkml/2008/6/12/8
> I can't find the ones patching i2c.

Well, I didn't disagree with the change. I think this is good change
(and good catch, btw).

Just mention it in the patch description (or better yet, you could send
a separate patch for this particular issue, it seems quite serious).


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
