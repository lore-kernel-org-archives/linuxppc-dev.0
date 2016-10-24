Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2rSF2k6TzDvgk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 09:24:45 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/pseries: fix spelling mistake: "Attemping" ->
 "Attempting"
To: Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>
References: <20161024220212.8464-1-colin.king@canonical.com>
 <CAGXu5j+RGsCwZ4SpnZKnoqt3zsyYPW8FdZ8vS7cRwr_L+0q2fA@mail.gmail.com>
 <1477347610.2111.6.camel@perches.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <f8a7d7ad-fd20-ffc7-8722-b711b47b2050@canonical.com>
Date: Mon, 24 Oct 2016 23:24:41 +0100
MIME-Version: 1.0
In-Reply-To: <1477347610.2111.6.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/10/16 23:20, Joe Perches wrote:
> On Mon, 2016-10-24 at 15:13 -0700, Kees Cook wrote:
>> On Mon, Oct 24, 2016 at 3:02 PM, Colin King <colin.king@canonical.com> wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> trivial fix to spelling mistake in pr_debug message
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>> index a1b63e0..c8929cb 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>> @@ -553,7 +553,7 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>>>  {
>>>         int rc;
>>>
>>> -       pr_debug("Attemping to remove CPU %s, drc index: %x\n",
>>> +       pr_debug("Attempting to remove CPU %s, drc index: %x\n",
>>>                  dn->name, drc_index);
>>>
>>>         rc = dlpar_offline_cpu(dn);
>>> --
>>> 2.9.3
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> scripts/spelling.txt should likely get an addition for "attemping". It
>> already has "attemps"...
> 
> There may not be enough of these to be useful and to my
> knowledge Colin isn't fixing comments

Indeed, I'm just using my kernelscan tool to scrape for errors in kernel
messages as these are seen by users as opposed to comments. Plus the
occurrences of the mistakes I'm finding are generally very small.

> 
> $ grep -rP --include=*.[ch] -wi "at+emp*t?ing" * | grep -vi attempting
> arch/x86/platform/uv/uv_nmi.c:/* Ping non-responding cpus attemping to force them into the NMI handler */
> arch/powerpc/platforms/pseries/hotplug-cpu.c:	pr_debug("Attemping to remove CPU %s, drc index: %x\n",
> 
