Return-Path: <julian.calaby@gmail.com>
Received: from mail-ig0-x241.google.com (mail-ig0-x241.google.com
 [IPv6:2607:f8b0:4001:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B308B1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 21:40:40 +1100 (AEDT)
Received: by mail-ig0-x241.google.com with SMTP id ik10so12766392igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 02:40:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160111123423-mutt-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
 <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
 <1452466336.7773.46.camel@perches.com>
 <20160111123423-mutt-send-email-mst@redhat.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 11 Jan 2016 21:40:18 +1100
Message-ID: <CAGRGNgU7=vNXZbgSwLs+bBueX1+rKACCRMi74hM+jP8MaX+-WA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joe Perches <joe@perches.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Whitcroft <apw@canonical.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
 David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, Jan 11, 2016 at 9:35 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
>> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
>> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > > Add virt_ barriers to list of barriers to check for
>> > > presence of a comment.
>> []
>> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>> > > @@ -5133,7 +5133,8 @@ sub process {
>> > >                 }x;
>> > >                 my $all_barriers = qr{
>> > >                         $barriers|
>> > > -                       smp_(?:$smp_barrier_stems)
>> > > +                       smp_(?:$smp_barrier_stems)|
>> > > +                       virt_(?:$smp_barrier_stems)
>> >
>> > Sorry I'm late to the party here, but would it make sense to write this as:
>> >
>> > (?:smp|virt)_(?:$smp_barrier_stems)
>>
>> Yes.  Perhaps the name might be better as barrier_stems.
>>
>> Also, ideally this would be longest match first or use \b
>> after the matches so that $all_barriers could work
>> successfully without a following \s*\(
>>
>> my $all_barriers = qr{
>>       (?:smp|virt)_(?:barrier_stems)|
>>       $barriers)
>> }x;
>>
>> or maybe add separate $smp_barriers and $virt_barriers
>>
>> <shrug>  it doesn't matter much in any case
>
> OK just to clarify - are you OK with merging the patch as is?
> Refactorings can come as patches on top if required.

I don't really care either way, I was just asking if it was possible.
If you don't see any value in that change, then don't make it.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
