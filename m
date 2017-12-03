Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqNsS0JznzDsF5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Dec 2017 21:04:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Michal Hocko <mhocko@suse.com>, Wei Wang <wei.w.wang@intel.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Memory corruption in powerpc guests with virtio_balloon (was Re:
 [PATCH v3] virtio_balloon: fix deadlock on OOM)
In-Reply-To: <20171201164129-mutt-send-email-mst@kernel.org>
References: <1510154064-9709-1-git-send-email-mst@redhat.com>
 <87o9nid3zn.fsf@concordia.ellerman.id.au>
 <20171201164129-mutt-send-email-mst@kernel.org>
Date: Sun, 03 Dec 2017 21:04:40 +1100
Message-ID: <87lgikw2iv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Fri, Dec 01, 2017 at 11:31:08PM +1100, Michael Ellerman wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > fill_balloon doing memory allocations under balloon_lock
>> > can cause a deadlock when leak_balloon is called from
>> > virtballoon_oom_notify and tries to take same lock.
...
>> 
>> 
>> Somehow this commit seems to be killing powerpc guests.
...
>
> Thanks for the report!
> A fix was just posted:
> virtio_balloon: fix increment of vb->num_pfns in fill_balloon()
>
> Would appreciate testing.

Yep that fixes it. Thanks.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
