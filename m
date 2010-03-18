Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id EA5E8B7DCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 02:54:30 +1100 (EST)
Date: Thu, 18 Mar 2010 18:47:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [V2 PATCH 08/10] arch/powerpc: Remove obsolete
	dev_archdata.of_node and of_devce.node
Message-ID: <20100318154747.GA7767@oksana.dev.rtsoft.ru>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152250.21082.35352.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100318152250.21082.35352.stgit@angua>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Thu, Mar 18, 2010 at 09:22:50AM -0600, Grant Likely wrote:
> Both dev_archdata.of_node and of_device.node are duplications of the
> device.of_node value.  This patch removes them.

Yeah, they're plain duplications since you introduced dev.of_node.
I wonder what was the problem with using dev.archdata.of_node?
Why dev.of_node is better?

Also, by using dev.of_node directly you have to introduce ugly
#ifdefs in the non-OF code (as in i2c patch), which you don't
need with transparent archdata and accessors, which you've just
removed:

> -static inline void dev_archdata_set_node(struct dev_archdata *ad,
> -					 struct device_node *np)
> -{
> -	ad->of_node = np;
> -}
> -
> -static inline struct device_node *
> -dev_archdata_get_node(const struct dev_archdata *ad)
> -{
> -	return ad->of_node;
> -}

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
