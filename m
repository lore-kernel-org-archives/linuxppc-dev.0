Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48FD11A03AC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 18:09:41 +1000 (AEST)
Message-ID: <1435478936.9432.29.camel@freescale.com>
Subject: Re: [v2,8/9] fsl/fman: Add FMan Port Support
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
CC: Paul Bolle <pebolle@tiscali.nl>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>
Date: Sun, 28 Jun 2015 03:08:56 -0500
In-Reply-To: <DM2PR03MB38337ABD2E9B11C92DCAF9FE6AB0@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1435174659-6876-1-git-send-email-igal.liberman@freescale.com>
 <1435274929.28572.28.camel@tiscali.nl>
 <DM2PR03MB38337ABD2E9B11C92DCAF9FE6AB0@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Why are these two parts being submitted separately?  Worse, the CC list seems 
to be different for each part as I'm not seeing the "DPAA ETH driver".

-Scott

On Sun, 2015-06-28 at 03:06 -0500, Liberman Igal-B31950 wrote:
> Hi Paul,
> All those exported functions are used by DPAA ETH driver, which was 
> submitted by Bucur Madalin (only fm_port_get_buffer_time_stamp() is not 
> used currently, I'll remove it).
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Paul Bolle [mailto:pebolle@tiscali.nl]
> > Sent: Friday, June 26, 2015 2:29 AM
> > To: Liberman Igal-B31950; netdev@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Bucur Madalin-
> > Cristian-B32716
> > Subject: Re: [v2,8/9] fsl/fman: Add FMan Port Support
> > 
> > On Wed, 2015-06-24 at 22:37 +0300,  igal.liberman@freescale.comwrote:
> > > --- a/drivers/net/ethernet/freescale/fman/fm_drv.c
> > > +++ b/drivers/net/ethernet/freescale/fman/fm_drv.c
> > 
> > > +struct fm_port_t *fm_port_drv_handle(const struct fm_port_drv_t
> > > +*port) {
> > > + return port->fm_port;
> > > +}
> > > +EXPORT_SYMBOL(fm_port_drv_handle);
> > 
> > I couldn't find any users of this function.
> > 
> > > +void fm_port_get_buff_layout_ext_params(struct fm_port_drv_t *port,
> > > +>        >       >       >       >       struct fm_port_params *params)
> > 
> > (Evolution 3.16 is a piece of ...).
> > 
> > > +{
> > > + params->data_align = 0;
> > > +}
> > > +EXPORT_SYMBOL(fm_port_get_buff_layout_ext_params);
> > 
> > Ditto.
> > 
> > > +int fm_get_tx_port_channel(struct fm_port_drv_t *port) {
> > > + return port->tx_ch;
> > > +}
> > > +EXPORT_SYMBOL(fm_get_tx_port_channel);
> > 
> > Ditto.
> > 
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/freescale/fman/fm_port_drv.c
> > 
> > > +void fm_set_rx_port_params(struct fm_port_drv_t *port,
> > > +                    struct fm_port_params *params)
> > > +{
> > +   [...]
> > > +}
> > > +EXPORT_SYMBOL(fm_set_rx_port_params);
> > 
> > Ditto.
> > 
> > (If you hear about my arrest for randomly attacking innocent people:
> > blame evolution 3.16!)
> > 
> > > +void fm_set_tx_port_params(struct fm_port_drv_t *port,
> > > +                    struct fm_port_params *params)
> > > +{
> > > + [...]
> > > +}
> > > +EXPORT_SYMBOL(fm_set_tx_port_params);
> > 
> > Ditto.
> > 
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/freescale/fman/port/fm_port.c
> > 
> > > +u64 *fm_port_get_buffer_time_stamp(const struct fm_port_t
> > *p_fm_port,
> > > +                            char *p_data)
> > > +{
> > > + [...]
> > > +}
> > > +EXPORT_SYMBOL(fm_port_get_buffer_time_stamp);
> > 
> > Ditto.
> > 
> > > +int fm_port_disable(struct fm_port_t *p_fm_port) {
> > > + [...]
> > > +}
> > > +EXPORT_SYMBOL(fm_port_disable);
> > 
> > This exports a function that I think is only used inside this file.
> > 
> > > +int fm_port_enable(struct fm_port_t *p_fm_port) {
> > > + [...]
> > > +}
> > > +EXPORT_SYMBOL(fm_port_enable);
> > 
> > And here I could again find no users of this function.
> > 
> > Thanks,
> > 
> > 
> > Paul Bolle
