Return-Path: <jonsmirl@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id 6476FDDF5B
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 00:07:05 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so3300286wra.1
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 07:07:03 -0700 (PDT)
Message-ID: <9e4733910807270707l65085acfq2f6f99c6d35c16a3@mail.gmail.com>
Date: Sun, 27 Jul 2008 10:07:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
In-Reply-To: <fa686aa40807262229r76750664v48405f13dcb84f23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080727011206.GD12191@secretlab.ca>
	<9e4733910807262144l7be98192l95dd526bf08e0434@mail.gmail.com>
	<fa686aa40807262229r76750664v48405f13dcb84f23@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/27/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun, Jul 27, 2008 at 12:44 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 7/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
>  >>
>  >> > Allow a custom ASOC machine driver with soc-of-simple
>  >>  >
>  >>  > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> >>  > diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
>  >>  > index 0382fda..dd2fa23 100644
>  >>  > --- a/sound/soc/fsl/soc-of-simple.c
>  >>  > +++ b/sound/soc/fsl/soc-of-simple.c
>  >>  > @@ -38,8 +38,8 @@ struct of_snd_soc_device {
>  >>  >       struct device_node *codec_node;
>  >>  >  };
>  >>  >
>  >>  > -static struct snd_soc_ops of_snd_soc_ops = {
>  >>  > -};
>  >>  > +static struct snd_soc_ops *machine_ops = NULL;
>  >>  > +static char *machine_name = NULL;
>  >>
>  >>
>  >> Doing this prevents multiple instances of this machine driver (which is
>  >>  exactly what I have on my board).  To register a machine driver it
>  >>  creates a 3-way bind condition instead of the existing 2-way one.  Right
>  >>  now it is easy to match up codec and platform drivers because a common
>  >>  key is available in the device tree.
>  >>
>  >>  Alternately, it might be okay to only allow for a single machine driver
>  >>  that is able to create multiple sound card instances, but this current
>  >>  code just uses the same name and ops for each registered device.
>  >>
>  > We need to call them fabric drivers since we already have machine
>  > drivers in arch/.... It is too confusing.
>
>
> heh, even worse; we've already got platform drivers under drivers/.
>  :-P  I disagree.  We need to be consistent with ALSA terminology, but
>  I will be more diligent to call them ASoC Machine drivers.
>
>
>  > My fabric driver was getting probed after the rest of ASOC bound,
>  > that's why I had to add the third condition.
>  >
>  > An important feature for me is the ability to compile in multiple
>  > fabric drivers and then get the right one selected based on the
>  > machine name in the device tree.
>
>
> Absolutely; this is a hard requirement as far as I'm concerned.
>
>  It is also a hard requirement for either multiple *active* ASoC
>  machine drivers, or support ASoC machine drivers that control multiple
>  ASoC device instances.
>
>
>  >  I'm doing via my machine driver.
>  >
>  > Could we dynamically build an OF fabric device entry with a compatible
>  > string like this: compatible="machinename-fabric,generic-fabric"
>  > Now a hard requirement for a fabric driver is ok since one of those
>  > two will load for sure. generic-fabric is just a do nothing driver
>  > that is always built in.
>
>
> Ugh; unfortunately that results in Linux internal details getting
>  leaked out to the device tree.  Not a good idea; especially when we
>  *know* this driver is a stop gap measure until v2 changes things on
>  us.

It has been pointed out several times that the sound fabric (wires,
external chips) really is a device so why can't it have a device tree
entry?

ASOCv2 still has this same problem of triggering the load of the fabric driver.

The Linuxism being exposed here is the split between the machine
driver and the fabric driver. Machine drivers are dynamically selected
by the device tree. The device tree model is assuming these are
combined into a single unit.

Simulating the merge of these two two into a single unit is why I
added the platform device creation code for my fabric driver to my
machine driver. But then we run in to the problem that Linux doesn't
support device drivers that override each other. There is no way to
have a dspeak01-fabric override a generic-fabric.

One solution to the override problem would be to make an overridable
callout in the machine driver that always creates a generic-fabric
platform device. I would then set a bit in my machine driver which
would cause the name to change from generic-fabric to dspeak01-fabric.

Another Linuxism involved here is creating devices without knowing
when or if a driver is ever going to show up. You hit this when making
the ASOC devices, say we only created a dspeak01-fabric platform
device and it hasn't been probed yet. How do you know if it is safe to
assume a generic-fabric? Is dspeak01-fabric coming and it just hasn't
been probed yet, or is it never coming at all?

>
>  But that still doesn't help the question of how to trigger loading of
>  the board specific machine drivers.  grumble.  But I do think that the
>  sanest approach is still to trigger on the top level model property in
>  the tree.
>
>  Oh well, if I need to add a dummy machine driver that matches on my
>  board, then that's what I'll do.  It certainly sidesteps all the ugly
>  heuristics of figuring out when custom code is needed.
>
>
>  > /* Trigger the platform specific ASOC driver to load */
>  > static struct platform_device platform = {
>  >        .name           = "dspeak01-fabric",
>  >        .id             = -1,
>  > };
>  >
>  > static struct platform_device *devices[] = {
>  >        &platform,
>  > };
>  >
>  > static void __init digispeaker_declare_platform_devices(void)
>  > {
>  >        mpc52xx_declare_of_platform_devices();
>  >        platform_add_devices(&devices[0], ARRAY_SIZE(devices));
>  > }
>
>
> I'm not convinced that all this is necessary.  I'm partial to just
>  having the ASoC machine module probe routine check the top level board
>  property and registering the ASoC machine driver if it is a match.
>  That also eliminates needing to build knowledge of the sound circuit
>  into the PPC platform driver which helps stem the tide of
>  proliferating platform files.
>
>  g.
>
>
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com
