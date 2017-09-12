Return-Path: <bsingharora@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170912150344.2d6702d1@roar.ozlabs.ibm.com>
References: <20170912043859.32473-1-bsingharora@gmail.com>
 <20170912150344.2d6702d1@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 12 Sep 2017 17:11:42 +1000
Message-ID: <CAKTCnzmSn+gyYKj0Bksiu0iBLnRkd+PwMjvE=LYe4x7dFrrHeA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Revisit MCE handling for UE Errors
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, skiboot list <skiboot@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 12, 2017 at 3:03 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> Hi Balbir,
>
> Very cool. How are you testing it? Is it failing memory pages
> and poisoning them out properly?
>

Yep, I tested it and it seems to work correctly so far. I am testing this
on a simulator with injected MCE UE errors for both the data and
instruction side.

> Looks like you have a printk in the machine_check_early path,
> which you shouldn't. I guess because we don't mark that context
> as an NMI. Which we could... but I think you want to put as
> little as possible in that path, so avoiding the print would
> be preferable. Perhaps you could mark the mce event somehow that
> the failure can be reported during processing it?
>

Good point, I did see that printk handles stuff via printk_nmi_enter/exit,
but its best avoided. Will spin v2

> Firmware logging is a good question, I could not really see
> where this all gets plumbed through. If this is expected to be
> a common problem for some types of attached memory, then we
> really need to build up a log of these errors that can be used
> to exclude the memory after a reboot too. Do we have anything
> like this capability in firmware?

It's to be built, we should log these to NVRAM and revisit at every
boot to isolate these pages

Balbir Singh.
