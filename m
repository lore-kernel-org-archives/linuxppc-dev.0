Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 7C552DDFB5
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 08:33:44 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so168973anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:33:42 -0700 (PDT)
Message-ID: <fa686aa40807171533l7920b96fi788eee0c72409e23@mail.gmail.com>
Date: Thu, 17 Jul 2008 16:33:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <dbrownell@users.sourceforge.net>
Subject: Re: [patch 2.6.26-rc3] spi: make spi_board_info.modalias a char array
In-Reply-To: <200805231031.25919.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200805211704.56761.david-b@pacbell.net>
	<20080521204633.8234c7d7.akpm@linux-foundation.org>
	<200805231031.25919.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David, are you going to pick up this and the other SPI of support
patches (linked below)?  Or should I push them through my tree?  (I'm
assuming that all the comments are addressed and they are ready to be
merged).

http://patchwork.ozlabs.org/linuxppc/patch?id=19597
http://patchwork.ozlabs.org/linuxppc/patch?id=19601
http://patchwork.ozlabs.org/linuxppc/patch?id=19602

Thanks,
g.

On Fri, May 23, 2008 at 11:31 AM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 21 May 2008, Andrew Morton wrote:
>> On Wed, 21 May 2008 17:04:56 -0700 David Brownell <david-b@pacbell.net> wrote:
>>
>> > From: Grant Likely <grant.likely@secretlab.ca>
>> >             ...
>> > -   proxy->modalias = chip->modalias;
>> > +   strncpy(proxy->modalias, chip->modalias, KOBJ_NAME_LEN);
>> >             ...
>>
>> a) strncpy() doesn't null-terminate the dest if it overran.  strlcpy() does.
>>
>> b) Given the uncertainly over the state of existing code, perhaps we
>>    should have an explicit check for overflows here, with a WARN_ON()?
>>
>> c) I think it's better to use sizeof() in the strlcpy() rather than
>>    duplicating the array size - it's a little more robust in the face
>>    of future changes and it is more obviously-correct (don't need to go
>>    elsewhere to check the size of the destination).
>
> Good points.  I usually try to use sizeof() myself, for exactly
> that reason.  Updated version (below) uses strlcpy, sizeof, WARN_ON.
>
>
>> d) KOBJ_NAME_LEN no longer exists in linux-next.  I'm not sure where
>>    it went - Greg and Kay have been up to their usual tricks.
>
> Yeech.  Replacing symbols with inline constants isn't good when
> the constant is what ensures various fields are the same size.
>
> BTW -- four comments on one line is pretty good even for you.  ;)
>
> - Dave
>
>
> ========= CUT HERE
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Currently, 'modalias' in the spi_device structure is a 'const char *'.
> The spi_new_device() function fills in the modalias value from a passed
> in spi_board_info data block.  Since it is a pointer copy, the new
> spi_device remains dependent on the spi_board_info structure after the
> new spi_device is registered (no other fields in spi_device directly
> depend on the spi_board_info structure; all of the other data is copied).
>
> This causes a problem when dynamically propulating the list of attached
> SPI devices.  For example, in arch/powerpc, the list of SPI devices can
> be populated from data in the device tree.  With the current code, the
> device tree adapter must kmalloc() a new spi_board_info structure for
> each new SPI device it finds in the device tree, and there is no simple
> mechanism in place for keeping track of these allocations.
>
> This patch changes modalias from a 'const char *' to a fixed char array.
> By copying the modalias string instead of referencing it, the dependency
> on the spi_board_info structure is eliminated and an outside caller does
> not need to maintain a separate spi_board_info allocation for each device.
>
> If searched through the code to the best of my ability for any references
> to modalias which may be affected by this change and haven't found anything.
> It has been tested with the lite5200b platform in arch/powerpc.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> [ cope with linux-next changes: KOBJ_NAME_LEN obliterated, etc ]
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/spi/spi.c       |    4 +++-
>  include/linux/spi/spi.h |    2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> --- a/drivers/spi/spi.c 2008-05-22 10:57:21.000000000 -0700
> +++ b/drivers/spi/spi.c 2008-05-22 18:56:16.000000000 -0700
> @@ -218,6 +218,8 @@ struct spi_device *spi_new_device(struct
>        if (!spi_master_get(master))
>                return NULL;
>
> +       WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
> +
>        proxy = kzalloc(sizeof *proxy, GFP_KERNEL);
>        if (!proxy) {
>                dev_err(dev, "can't alloc dev for cs%d\n",
> @@ -229,7 +231,7 @@ struct spi_device *spi_new_device(struct
>        proxy->max_speed_hz = chip->max_speed_hz;
>        proxy->mode = chip->mode;
>        proxy->irq = chip->irq;
> -       proxy->modalias = chip->modalias;
> +       strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
>
>        snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
>                        "%s.%u", master->dev.bus_id,
> --- a/include/linux/spi/spi.h   2008-05-22 10:57:21.000000000 -0700
> +++ b/include/linux/spi/spi.h   2008-05-23 10:21:41.000000000 -0700
> @@ -82,7 +82,7 @@ struct spi_device {
>        int                     irq;
>        void                    *controller_state;
>        void                    *controller_data;
> -       const char              *modalias;
> +       char                    modalias[32];
>
>        /*
>         * likely need more hooks for more protocol options affecting how
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
