Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9796D2C02FA
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Jun 2013 14:50:52 +1000 (EST)
Message-ID: <1370062229.3766.28.camel@pasglop>
Subject: Re: [PATCH v3 5/8] powerpc/pseries: Read rtas partition via pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:50:29 +1000
In-Reply-To: <1370062185.3766.27.camel@pasglop>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
 <20130425101851.21017.90041.stgit@aruna-ThinkPad-T420>
 <1370062185.3766.27.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, ccross@android.com, keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-01 at 14:49 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-04-25 at 15:48 +0530, Aruna Balakrishnaiah wrote:
> > This patch set exploits the pstore subsystem to read details of rtas partition
> > in NVRAM to a separate file in /dev/pstore. For instance, rtas details will be
> > stored in a file named [rtas-nvram-4].
> > 
>  .../...
> 
> > diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> > index 75d0176..d7a8fe9 100644
> > --- a/include/linux/pstore.h
> > +++ b/include/linux/pstore.h
> > @@ -35,6 +35,8 @@ enum pstore_type_id {
> >  	PSTORE_TYPE_MCE		= 1,
> >  	PSTORE_TYPE_CONSOLE	= 2,
> >  	PSTORE_TYPE_FTRACE	= 3,
> > +	/* PPC64 partition types */
> > +	PSTORE_TYPE_PPC_RTAS	= 4,
> >  	PSTORE_TYPE_UNKNOWN	= 255
> >  };
> >  
> 
> Not sure about that list...
> 
> What do you mean by "RTAS" ? The error logs ? What about our "common"
> partition (firmware settings ?). We should probably at least define
> a generic PSTORE_TYPE_FIRMWARE for firmware private stuff...

Scrap it, I just noticed your next patch doing that,... see comment
there.

Cheers,
Ben.
