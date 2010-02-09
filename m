Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id 60A28B7D2D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:25:54 +1100 (EST)
Received: by iwn41 with SMTP id 41so2857536iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:25:53 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205205043.GB4178@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205043.GB4178@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:25:22 -0700
Message-ID: <fa686aa41002090925q30f362d6x4d14894a72439125@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: Introduce safe accessors for node->data
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:50 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Platform code use node->data to store some private information
> associated with a node.
>
> Previously there was no need for any locks and accessors since we were
> initializing the data mostly at boot time and never modified it later.
>
> Though, nowadays OF GPIO infrastructure supports GPIO chips detaching,
> so to handle this correctly we have to introduce locking for the
> node->data field.

I'm not convinced this is needed.  What's wrong with using the
whole-tree devtree_lock?

g.
