Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id A378367B9B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 16:18:29 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2585186ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Dec 2006 21:18:26 -0800 (PST)
Message-ID: <528646bc0612032118i689e9c83gdfc841a3d7b91fcf@mail.gmail.com>
Date: Sun, 3 Dec 2006 22:18:25 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [LIBFDT] Fixup byteswapping code
In-Reply-To: <20061204015329.GA4790@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<20061204015329.GA4790@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/3/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> I just applied a patch with a whole batch of endian fixes, obsoleting
> this patch of yours.

Cool, looks good and the tests pass on my machine now.

Now; here's an AMD64 related bug; consider line #44 in libfdt_internal.h:

#define PTR_ERROR(code)         (void *)(-(code))

Followed by line #67 in libfdt.h:

#define fdt_ptr_error(ptr) \
	( (((long)(ptr) < 0) && ((long)(ptr) >= -FDT_ERR_MAX)) ? -(long)(ptr) : 0 )


'code' being an integer.

This requires a hacky cast from int to pointer and back again, and it
makes the assumption that int and void* are the same size.  However,
on a x86_64 system (not sure about power64), int is 32 bits and void*
is 64.  Therefore; a return of (void*)-1 results in address
0xffffffff; not 0xffffffffffffffff.  0xffffffff is right in the middle
of valid address ranges.

This, of course, produces the warning: "cast to pointer from integer
of different size"

I believe the accepted convention (at least in the kernel) is to
return NULL on error, and libfdt should probably follow that
convention.  If you must return the actual error code; maybe rework
the API to accept a void** argument to be used to pass back the
pointer and use 'return code', or include an 'int*' argument for
passing back the err code.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
