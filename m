Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3D701A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 19:23:06 +1100 (AEDT)
Date: Tue, 16 Feb 2016 09:23:02 +0100
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, Balbir Singh <bsingharora@gmail.com>,
 Jessica Yu <jeyu@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace
 location during build
Message-ID: <20160216082302.GA20522@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com> <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216054701.GA20570@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 11:17:02AM +0530, Kamalesh Babulal wrote:
> * Petr Mladek <pmladek@suse.com> [2016-02-12 17:45:17]:
> >  int test(int a)
> >  {
> > +	printk("%d\n", a);
> >  	return ++a;
> >  }
> 
> Thanks. This workaround, helped to load sample livepatch module.

N.b.: if you try to livepatch/trace such a leaf function without
global dependencies, it will crash if that function got called with
a different TOC value. Hence this whole testing.

You may alternatively try my gcc patch ;-)

Another caveat is functions with stack arguments (>8 args, varargs).
My code needs special precautions then because of the return helper.

	Torsten
