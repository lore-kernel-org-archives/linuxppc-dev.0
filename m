Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by ozlabs.org (Postfix) with ESMTP id AEC11DDF1F
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 07:56:03 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so471974ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 12:56:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090306204623.GJ11787@kernel.dk>
References: <20090228204622.29719.55082.stgit@localhost.localdomain>
	<fa686aa40903060805i489d8676waad08e8263c02fe@mail.gmail.com>
	<20090306204623.GJ11787@kernel.dk>
Date: Fri, 6 Mar 2009 13:56:01 -0700
Message-ID: <fa686aa40903061256n35a2f8eck1a6592964daa949b@mail.gmail.com>
Subject: Re: [PATCH] Fix Xilinx SystemACE driver to handle empty CF slot
From: Grant Likely <grant.likely@secretlab.ca>
To: Jens Axboe <jens.axboe@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 1:46 PM, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Fri, Mar 06 2009, Grant Likely wrote:
>> > The SystemACE driver does not handle an empty CF slot gracefully. =A0A=
n
>> > empty CF slot ends up hanging the system. =A0This patch adds a check f=
or
>> > the CF state and stops trying to process requests if the slot is empty=
.
>
> So with patches like this, it's always nice to know what your target is.
> Do you want this in .29, or just queued up for .30? It's not always easy
> to judge the urgency of such patches :-)

The driver completely falls down and hangs the system if the CF slot
is empty, so I would like to get it into .29.  On the other hand, it
has been a long standing issue, so if merging it will raise any
eyebrows then I'm okay to wait for .30.

> Also, I note that you are using end_request() throughout the driver. We
> really want to get away from that, you should be using blk_end_request()
> as that will handle full requests and not just segment-by-segment. No
> worries for this patch, but you may want to consider that for a future
> patch.

Okay, will do.

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
