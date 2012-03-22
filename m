Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29E0EB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 14:40:02 +1100 (EST)
Received: by dady9 with SMTP id y9so2651391dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 20:40:00 -0700 (PDT)
Date: Wed, 21 Mar 2012 20:39:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
Message-ID: <20120322033957.GA16914@kroah.com>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <1332366068.3858.50.camel@key-ThinkPad-W510>
 <20120321221517.GB30748@kroah.com>
 <1332381004.2982.65.camel@pasglop>
 <1332385050.2982.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332385050.2982.71.camel@pasglop>
Cc: rcj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2012 at 01:57:30PM +1100, Benjamin Herrenschmidt wrote:
> +int __vio_register_driver(struct vio_driver *viodrv, struct module *owner,
> +			const char *mod_name)
>  {
>  	viodrv->driver.bus = &vio_bus_type;
> +	viodrv->driver.name = viodrv->name;
> +	viodrv->driver.bus = &vio_bus_type;
> +	viodrv->driver.owner = owner;
> +	viodrv->driver.mod_name = mod_name;

Any reason you set .bus twice?
