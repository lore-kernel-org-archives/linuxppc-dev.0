Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 43893DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 03:49:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1017279anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Dec 2007 08:49:35 -0800 (PST)
Message-ID: <fa686aa40712050849j2da48e9eq3e46b20bc1d72b45@mail.gmail.com>
Date: Wed, 5 Dec 2007 09:49:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Kernel symbol version history
In-Reply-To: <4756CF15.2090805@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4756CF15.2090805@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/5/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     This might be slightly OT here, but would anyone know where there
> might be a reference that indicates at precisely what version a given
> symbol either appeared or disappeared within the  Linux kernel ?
>
>      As an example if a driver is supposed to work for 2.6 and 2.4 and
> uses sysfs, or cdev, or alloc_chr_dev_region or ...
>     How can one tell at what point that api or symbol appeared so that
> the proper conditionals appear within the driver.

the 'gitk' tool allows you to search for the addition or removal of a
string.  You

>
>     The last one that bit me was I made a collection of casting changes
> to address 64bit vs. 32bit targets, and found that using the C99 fixed
> size types - uint32_t, ... made life much more pleasant, after putting
> them I nobody else could build because uintptr_t did not appear until
> 2.6.24, and I still have not figured out exactly when uint32_t etc.
> appeared.
>
>     I would think there ought to be some resource besides group memory
> to look this up ?
>     Is there a way to use git to look back through the history of a
> symbol rather than a file.

grant@trillian:~/hacking/linux-2.6$ grep "uint32_t" include/* -r | grep typedef
include/linux/types.h:typedef           __u32           uint32_t;
grant@trillian:~/hacking/linux-2.6$ git log -p include/linux/types.h | vim -
(Search for the string uint32_t)

Looks like it was there before Linus started using git.


>
>
>
> --
> Dave Lynch                                                  DLA Systems
> Software Development:                                    Embedded Linux
> 717.627.3770           dhlii@dlasys.net           http://www.dlasys.net
> fax: 1.253.369.9244                                Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies too numerous to list.
>
> "Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
> Albert Einstein
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
