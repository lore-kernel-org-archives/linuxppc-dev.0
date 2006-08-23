Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 197DB67CF5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 19:15:02 +1000 (EST)
Subject: Re: [PATCH 2/2] uninorth: Add module param 'aperture' for aperture
	size
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156285033.21752.107.camel@localhost.localdomain>
References: <115608447678-git-send-email->  <11560844762890-git-send-email->
	<1156176559.16513.78.camel@thor.lorrainebruecke.local>
	<1156231536.21752.100.camel@localhost.localdomain>
	<1156236954.16513.141.camel@thor.lorrainebruecke.local>
	<1156285033.21752.107.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 23 Aug 2006 11:14:41 +0200
Message-Id: <1156324481.30411.50.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 08:17 +1000, Benjamin Herrenschmidt wrote:
> > > It's basically expected that we set it ourselves and a module option 
> > > doesn't seem like a terribly good idea to me...
> > 
> > Well, wasn't it you who suggested this? :)
> 
> Possibly, I don't always have good ideas :) I would rather have that
> size be configured by the client driver... 

That would certainly be ideal. Digging into the code a little deeper, it
seems like the backend's insert_memory hook should be able to adjust the
GATT table size on the fly. Not sure __get_free_pages() is expected to
succeed for dozens of pages at any given time though.


> oh well, let's workaround that for now by using a better default _and_ 
> the module option.

Agreed, I'll re-send the patch with the default changed to 64M.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
