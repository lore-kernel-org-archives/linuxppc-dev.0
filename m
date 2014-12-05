Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3C4F1A0C7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 14:27:28 +1100 (AEDT)
Received: by mail-ig0-f176.google.com with SMTP id l13so160928iga.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Dec 2014 19:27:26 -0800 (PST)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
References: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Thu, 4 Dec 2014 22:27:06 -0500
Message-ID: <CALZtONBUDyN7OOMV9ziDXMhFN9+bOcsYvJ0an_7T0VV0Hz+8WQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
To: Ashutosh Dixit <ashutosh.dixit@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Foley <pefoley2@pefoley.com>,
 Siva Yerramreddy <yshivakrishna@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Sudeep Dutt <sudeep.dutt@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nikhil Rao <nikhil.rao@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Jennings <sjennings@variantweb.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 4, 2014 at 4:27 PM, Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
> mic/mpssd along with MIC drivers are currently only usable on
> x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
> big-endian systems.

Only building for x86_64 is fine, but in that case what's the point of
leaving the htole16() et. al. functions in mpssd.c?  Shouldn't they be
removed?

>
> Reported-by: Daniel Borkmann <dborkman@redhat.com>
> Reported-by: Dan Streetman <ddstreet@gmail.com>
> Suggested-by: Peter Foley <pefoley2@pefoley.com>
> Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> ---
>  Documentation/mic/mpssd/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mic/mpssd/Makefile b/Documentation/mic/mpssd/Makefile
> index 0f31568..f47fe6b 100644
> --- a/Documentation/mic/mpssd/Makefile
> +++ b/Documentation/mic/mpssd/Makefile
> @@ -1,5 +1,5 @@
>  # List of programs to build
> -hostprogs-y := mpssd
> +hostprogs-$(CONFIG_X86_64) := mpssd
>
>  mpssd-objs := mpssd.o sysfs.o
>
> --
> 2.0.0.rc3.2.g998f840
>
