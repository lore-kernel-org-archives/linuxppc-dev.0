Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C282AB6F64
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 12:32:18 +1100 (EST)
Received: by bkcjk13 with SMTP id jk13so904733bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2011 17:32:13 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20111202005150.2e9fde43@bob.linux.org.uk>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
 <20111202005150.2e9fde43@bob.linux.org.uk>
Date: Thu, 1 Dec 2011 20:32:13 -0500
Message-ID: <CAP=VYLpn7kJJ6we3diqhCR+QzjQtzTmkEzSP-uw07=udJKYK6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: make bugs field not specific to 8250 type
 uarts.
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 1, 2011 at 7:51 PM, Alan Cox <alan@linux.intel.com> wrote:
>> Make the bugs field part of the globally visible struct
>> uart_port and remove the 8250 specific one.
>
> Except all the bits in it are 8250 specific things or names that are
> meaningless in generic form - no. I also don't want to encourage flags
> and bug bits. We already have too many and its making the code a mess.
> So right now we want less not more.

The bits in "bugs" are only passed through -- the idea is that there is
no "interpretation" of them by any generic layer -- only that they prop
from the arch down to the driver which knows what they mean.

I can understand the "want less not more" mentality -- I was thinking
the same thing when I was looking at the replication of fields between
uart_port and uart_8250_port, and toying with the idea of helping clean
that up....  (separate topic, to be sure.)

If you have an idea in mind how arch/platform code should cleanly
pass data about known uart bugs to the uart driver, then let me know
what you have in mind.  I've no real attachment to what I proposed
here -- it just happened to be the solution I thought would be the least
offensive.  If there is a better idea floating around, I'll go ahead and
try to implement it.

Thanks,
Paul.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
