Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C2A5DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 14:53:58 +1000 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
	<m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
	<1177382544.14873.57.camel@localhost.localdomain>
	<m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
	<17965.35054.835790.275270@cargo.ozlabs.ibm.com>
Date: Mon, 23 Apr 2007 22:51:50 -0600
In-Reply-To: <17965.35054.835790.275270@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 24 Apr 2007 14:34:54 +1000")
Message-ID: <m1647mv0gp.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Eric W. Biederman writes:
>
>> Well the basic problem is that for any piece of code that can be modular
>> we need a way to ensure all threads it has running are shutdown when we
>> remove the module.
>
> The EEH code can't be modular, and wouldn't make any sense to be
> modular, since it's part of the infrastructure for accessing PCI
> devices.

Agreed.  However most kthread users are modular and make sense to
be so we need to design to handle modular users.

I don't think the idiom of go fire off a thread to handle something
is specific to non-modular users.

Eric
