Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0105.hostedemail.com
 [216.40.44.105])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmQm85sl8zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 18:19:20 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 0C77218017FD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 08:12:59 +0000 (UTC)
Message-ID: <1497255172.3254.14.camel@perches.com>
Subject: Re: [next-20170609][bisected 4d72ba0] WARNING: CPU: 8 PID: 11043 at
 lib/vsprintf.c:1945 set_precision
From: Joe Perches <joe@perches.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, sachinp <sachinp@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 01:12:52 -0700
In-Reply-To: <1497253993.15415.25.camel@abdul.in.ibm.com>
References: <1497253993.15415.25.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-12 at 13:23 +0530, Abdul Haleem wrote:
> Hi Rasmus,
> 
> With commit (4d72ba0-lib/vsprintf.c: warn about too large precisions..)
> 
> WARN_ONCE is being triggered while running trinity 
> $ git clone https://github.com/kernelslacker/trinity.git
> $ cd trinity;./configure;make 
> $ ./trinity --dangerous
> 
> Machine : Power 8 PowerVM LPAR
> gcc : version 5.2.1
> config : attached
> 
> 
> In file lib/vsprintf.c at line 1945:
> set_precision(struct printf_spec *spec, int prec)
> {
>     spec->precision = prec;
>     if (WARN_ONCE(spec->precision != prec, "precision %d too large",
> prec)) {
>         spec->precision = clamp(prec, 0, PRECISION_MAX);
>     }
> }

Presumably there should be a PATH_MAX maximum check added
to the strlen(name) in get_fs_type.

fs/filesystems.c:271

struct file_system_type *get_fs_type(const char *name)
{
	struct file_system_type *fs;
	const char *dot = strchr(name, '.');
	int len = dot ? dot - name : strlen(name);

	fs = __get_fs_type(name, len);
	if (!fs && (request_module("fs-%.*s", len, name) == 0))
		fs = __get_fs_type(name, len);
