Return-Path: <linasvepstas@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id B79FBDE057
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:30:40 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so461709fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 09:30:39 -0800 (PST)
Message-ID: <3ae3aa420802150930w48378c2fk830f8f1a13b2498b@mail.gmail.com>
Date: Fri, 15 Feb 2008 11:30:39 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Tony Breeds" <tony@bakeyournoodle.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
In-Reply-To: <20080215010528.GI6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B13D2E.1070001@austin.ibm.com> <47B146BE.5010807@austin.ibm.com>
	<20080215010528.GI6887@bakeyournoodle.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 14/02/2008, Tony Breeds <tony@bakeyournoodle.com> wrote:
> On Tue, Feb 12, 2008 at 01:11:58AM -0600, Manish Ahuja wrote:

>  > +static ssize_t
>  > +show_release_region(struct kset * kset, char *buf)
>  > +{
>  > +     return sprintf(buf, "ola\n");
>  > +}
>  > +
>  > +static struct subsys_attribute rr = __ATTR(release_region, 0600,
>  > +                                      show_release_region,
>  > +                                      store_release_region);
>
>
> Any reason this sysfs attribute can't be write only? The show method
>  doesn't seem needed.

This was supposed to be a place-holder; a later patch would add detailed
info.  The goal was to  have user-land tools that would operate these files
to progressively dump and release memory regions; however, until these
userland tools get written, the proper interface remains murky  (e.g.
real addresses? virtual addresses? just delta's or a whole memory map?
some sort of numa flags or whatever?)

--linas
