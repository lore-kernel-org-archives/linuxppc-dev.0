Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 4D9E3DDF31
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:29:39 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1257644anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 22:29:37 -0700 (PDT)
Message-ID: <fa686aa40807262229r76750664v48405f13dcb84f23@mail.gmail.com>
Date: Sat, 26 Jul 2008 23:29:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
In-Reply-To: <9e4733910807262144l7be98192l95dd526bf08e0434@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080727011206.GD12191@secretlab.ca>
	<9e4733910807262144l7be98192l95dd526bf08e0434@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 27, 2008 at 12:44 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
>>
>> > Allow a custom ASOC machine driver with soc-of-simple
>>  >
>>  > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>>  > diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
>>  > index 0382fda..dd2fa23 100644
>>  > --- a/sound/soc/fsl/soc-of-simple.c
>>  > +++ b/sound/soc/fsl/soc-of-simple.c
>>  > @@ -38,8 +38,8 @@ struct of_snd_soc_device {
>>  >       struct device_node *codec_node;
>>  >  };
>>  >
>>  > -static struct snd_soc_ops of_snd_soc_ops = {
>>  > -};
>>  > +static struct snd_soc_ops *machine_ops = NULL;
>>  > +static char *machine_name = NULL;
>>
>>
>> Doing this prevents multiple instances of this machine driver (which is
>>  exactly what I have on my board).  To register a machine driver it
>>  creates a 3-way bind condition instead of the existing 2-way one.  Right
>>  now it is easy to match up codec and platform drivers because a common
>>  key is available in the device tree.
>>
>>  Alternately, it might be okay to only allow for a single machine driver
>>  that is able to create multiple sound card instances, but this current
>>  code just uses the same name and ops for each registered device.
>>
> We need to call them fabric drivers since we already have machine
> drivers in arch/.... It is too confusing.

heh, even worse; we've already got platform drivers under drivers/.
:-P  I disagree.  We need to be consistent with ALSA terminology, but
I will be more diligent to call them ASoC Machine drivers.

> My fabric driver was getting probed after the rest of ASOC bound,
> that's why I had to add the third condition.
>
> An important feature for me is the ability to compile in multiple
> fabric drivers and then get the right one selected based on the
> machine name in the device tree.

Absolutely; this is a hard requirement as far as I'm concerned.

It is also a hard requirement for either multiple *active* ASoC
machine drivers, or support ASoC machine drivers that control multiple
ASoC device instances.

>  I'm doing via my machine driver.
>
> Could we dynamically build an OF fabric device entry with a compatible
> string like this: compatible="machinename-fabric,generic-fabric"
> Now a hard requirement for a fabric driver is ok since one of those
> two will load for sure. generic-fabric is just a do nothing driver
> that is always built in.

Ugh; unfortunately that results in Linux internal details getting
leaked out to the device tree.  Not a good idea; especially when we
*know* this driver is a stop gap measure until v2 changes things on
us.

But that still doesn't help the question of how to trigger loading of
the board specific machine drivers.  grumble.  But I do think that the
sanest approach is still to trigger on the top level model property in
the tree.

Oh well, if I need to add a dummy machine driver that matches on my
board, then that's what I'll do.  It certainly sidesteps all the ugly
heuristics of figuring out when custom code is needed.

> /* Trigger the platform specific ASOC driver to load */
> static struct platform_device platform = {
>        .name           = "dspeak01-fabric",
>        .id             = -1,
> };
>
> static struct platform_device *devices[] = {
>        &platform,
> };
>
> static void __init digispeaker_declare_platform_devices(void)
> {
>        mpc52xx_declare_of_platform_devices();
>        platform_add_devices(&devices[0], ARRAY_SIZE(devices));
> }

I'm not convinced that all this is necessary.  I'm partial to just
having the ASoC machine module probe routine check the top level board
property and registering the ASoC machine driver if it is a match.
That also eliminates needing to build knowledge of the sound circuit
into the PPC platform driver which helps stem the tide of
proliferating platform files.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
