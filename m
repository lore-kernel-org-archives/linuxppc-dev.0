Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3216C1A0BCC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 06:54:03 +1100 (AEDT)
Received: by mail-ig0-f176.google.com with SMTP id l13so1475086iga.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Dec 2014 11:54:01 -0800 (PST)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <m3iohq7yem.fsf@adixit-yct.ra.intel.com>
References: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
 <CALZtONBUDyN7OOMV9ziDXMhFN9+bOcsYvJ0an_7T0VV0Hz+8WQ@mail.gmail.com>
 <m3iohq7yem.fsf@adixit-yct.ra.intel.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Fri, 5 Dec 2014 14:53:40 -0500
Message-ID: <CALZtONA2uk7ZN=f5S-DnmcOwhqtzLXmppk48YqfgjwA+vQuhtw@mail.gmail.com>
Subject: Re: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
To: Ashutosh Dixit <ashutosh.dixit@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Foley <pefoley2@pefoley.com>,
 Siva Yerramreddy <yshivakrishna@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Dutt,
 Sudeep" <sudeep.dutt@intel.com>, "Yokoyama, Caz" <caz.yokoyama@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rao,
 Nikhil" <nikhil.rao@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jennings <sjennings@variantweb.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Chandramouli,
 Dasaratharaman" <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 5, 2014 at 1:18 PM, Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
> On Thu, Dec 04 2014 at 07:27:06 PM, Dan Streetman <ddstreet@ieee.org> wrote:
>> On Thu, Dec 4, 2014 at 4:27 PM, Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
>>> mic/mpssd along with MIC drivers are currently only usable on
>>> x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
>>> big-endian systems.
>>
>> Only building for x86_64 is fine, but in that case what's the point of
>> leaving the htole16() et. al. functions in mpssd.c?  Shouldn't they be
>> removed?
>
> I am hoping that once glibc is fixed we can remove this limitation on
> building only for x86_64, so I'd rather htole16() et. al. stayed.

FYI, the bug I opened with glibc:
https://sourceware.org/bugzilla/show_bug.cgi?id=17679

was rejected because Andreas states "C does not allow function calls
in file scope."  The suggestion was made to try to fix gcc, but
honestly I don't have the time (or energy) to push for a gcc change
just for this. :-)

I do think it's too bad that glibc hto* functions don't work in file
scope (i.e. with static/global var initialization) for constant values
(using them with variables is different, which is why
__bswap_constant_* works in file scope but __bswap_* doesn't), since
it's simply a 2-step process that's entirely doable by the
preprocessor and/or compiler; just check if target endianness matches
desired endianness, and if not the compiler does a simple byte swap of
the constant value.

Anyway, I doubt glibc and/or gcc will be updated anytime soon to allow this.

>  As I
> said earlier, I'm fine with your patch too, but restricting the build
> for x86_64 seems to be the smallest patch which provides an acceptable
> solution.

Fine with me too.  It'll get big-endian building again.
