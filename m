Return-Path: <FlorianSchandinat@gmx.de>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
 by ozlabs.org (Postfix) with SMTP id 40250B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 06:52:56 +1100 (EST)
Message-ID: <4F6A2FEC.6040003@gmx.de>
Date: Wed, 21 Mar 2012 19:45:48 +0000
From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
MIME-Version: 1.0
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>	<1332031585.3105.197.camel@pasglop>	<CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>	<1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
In-Reply-To: <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/19/2012 02:42 PM, Dmitry Eremin-Solenikov wrote:
> On Mon, Mar 19, 2012 at 12:49 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Sun, 2012-03-18 at 18:04 +0400, Dmitry Eremin-Solenikov wrote:
>>> On Sun, Mar 18, 2012 at 4:46 AM, Benjamin Herrenschmidt
>>> <benh@kernel.crashing.org> wrote:
>>>> In fact, we could make the new structure such that it doesn't break
>>>> userspace compatibility with 64-bit architectures at all, ie, the "new"
>>>> and "compat" ioctl could remain entirely equivalent on 64-bit.
>>>
>>> I remember stuff about compat_ioctl, but I have never used/implemented
>>> that. Are there any details of requirements for the structures being passed?
>>
>> In that specific case, I meant something else. IE. The old ioctl could
>> remain unchanged, and the new ioctl make the same as the old one on
>> 64-bit platforms.
> 
> I don't think this kind of magic would be good. I'd just stick to the new
> ioctl.

I finally found where we started to discuss this issue, for reference
"sm501fb.c: support mmap on PPC440SPe/PPC440EPx" back in May 2010.

The thing I don't remember is why we consider exporting the physical
address to userspace desirable (or even necessary). Fixing the generic
mmap would be trivial without breaking or adding any userspace ABI, I
think. Just adding those things to fb_info and adjusting fb_mmap should
do the trick, shouldn't it?


Best regards,

Florian Tobias Schandinat
