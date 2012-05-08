Return-Path: <hughd@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06C22B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 11:14:07 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so9831905pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2012 18:14:05 -0700 (PDT)
Date: Mon, 7 May 2012 18:13:45 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next oops in windfarm startup
In-Reply-To: <1336435741.2540.184.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1205071812250.3089@eggly.anvils>
References: <alpine.LSU.2.00.1205070851020.1416@eggly.anvils>
 <1336435741.2540.184.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 8 May 2012, Benjamin Herrenschmidt wrote:
> On Mon, 2012-05-07 at 08:57 -0700, Hugh Dickins wrote:
> > Hi Ben,
> > 
> > 3.4.0-rc5-next-20120504 and 3.4.0-rc6-next-20120507
> > crash while booting the PowerMac G5: I have to revert
> > your commit e326b30fda9985a2e7fda6fb9212b86bf025c39
> > powerpc/pmac: Convert windfarm_smu_sat to new i2c probing
> > to get a working system.
> 
> Argh, stoopid me ... and I thought I had tested it .... just
> on the wrong machine. Oh well try this and let me know:
> 
> powerpc/windfarm: Fix crash on SMU based machine after i2c conversion
> 
> We no longer get the device node in platform_data but instead
> where it belongs in struct device, so get it from there instead
> of blowing up.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Yep, that fixes it for me: thanks a lot!

Hugh

> ---
> 
> diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
> index e2989ce..426e810 100644
> --- a/drivers/macintosh/windfarm_smu_sat.c
> +++ b/drivers/macintosh/windfarm_smu_sat.c
> @@ -204,7 +204,7 @@ static struct wf_sensor_ops wf_sat_ops = {
>  static int wf_sat_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	struct device_node *dev = client->dev.platform_data;
> +	struct device_node *dev = client->dev.of_node;
>  	struct wf_sat *sat;
>  	struct wf_sat_sensor *sens;
>  	const u32 *reg;
