Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18467.55307.873805.423244@cargo.ozlabs.ibm.com>
Date: Fri, 9 May 2008 14:50:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Add null pointer check to of_find_property
In-Reply-To: <1210202466.16180.1.camel@localhost>
References: <1210187999-20274-1-git-send-email-timur@freescale.com>
	<1210202466.16180.1.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> On Wed, 2008-05-07 at 14:19 -0500, Timur Tabi wrote:
> > Update function of_find_property() to return NULL if the device_node passed
> > to it is also NULL.  Otherwise, passing NULL will cause a null pointer
> > dereference.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> > 
> > This patch allows callers to do this:
> 
> np = of_find_compatible_node(...);
> prop = of_get_property(np);
> if (!prop)
>      goto error;
> 
> ...
> 
> error:
>  of_node_put(np)
> 
> :)

And of_node_put looks like this:

void of_node_put(struct device_node *node)
{
        if (node)
                kref_put(&node->kref, of_node_release);
}

so it's OK.

:)

Paul.
