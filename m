Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D095DDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 18:15:22 +1000 (EST)
Date: Fri, 20 Jul 2007 17:15:09 +0900 (JST)
Message-Id: <20070720.171509.-1300522247.kouish@swc.toshiba.co.jp>
To: miltonm@bga.com
Subject: Re: [PATCH 2/2] fix showing xmon help
In-Reply-To: <664cbe49d76cfcba9d8a86e3a6946a2a@bga.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller <miltonm@bga.com> wrote:
> On Jul 18, 2007, at 11:12 AM, Andreas Schwab wrote:
> 
> > Milton Miller <miltonm@bga.com> writes:
> >
> >>>                 case '?':
> >>> -                       printf(help_string);
> >>> +                       xmon_puts(help_string);
> >>>                         break;
> >>>
> >>
> >> nonstdio.h #defines printf to xmon_printf.  Please add a similar
line
> >> for puts, and use the define here.  (It will avoid an unnecessary
> >> difference with the user space version).
> >
> > User space puts add a newline, which this xmon_puts doesn't.
> >
> > Andreas.
> 
> Good point.  This should be xmon_fputs #defined to fputs.
> 
> milton

Should we change like below?

define fputs:
 #define fputs(str,stream)  xmon_fputs(str) /* stream is ignored. */

show the help string:
 fputs(help_string, stdout);

Best regards,
Kou Ishizaki
