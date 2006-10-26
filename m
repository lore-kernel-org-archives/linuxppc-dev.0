Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E233568053
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 06:50:57 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9QKonJf023800
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Oct 2006 22:50:50 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45411F14.6020308@246tNt.com>
Date: Thu, 26 Oct 2006 22:48:20 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: status of mpc52xx with arch=powerpc?
References: <20061018130628.GE6202@localhost.localdomain>	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>	<1161740815.22582.1.camel@localhost.localdomain>	<528646bc0610242325m45fa610egb47f118f5f4f6f5e@mail.gmail.com>	<4b73d43f0610261307sd0668d1x6e535880a46e71d3@mail.gmail.com>
	<528646bc0610261336i61521af3y3a5f134bb8c2f8da@mail.gmail.com>
In-Reply-To: <528646bc0610261336i61521af3y3a5f134bb8c2f8da@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/26/06, John Rigby <jcrigby@gmail.com> wrote:
>> Does Bestcomm dma belong in here somewhere?
>
> I don't think so for embedded targets; but I may be wrong.  Of course;
> I think the kernel should be responsible for setting up the bestcomm
> tasks.  If a spec is defined for how firmware could preload bestcomm
> tasks, then maybe.
Yes, we discussed that on IRC.
For I got from it would be something like that :

We would use the API we worked earlier on (Dale, Andrey, John, ...).
To add support of fw preloaded task :
 - The bestcomm.ko module would be used when bestcomm is completely
controlled by the kernel
- A different module but with the same exported function would be used
when the fw has a part to play in the init. That allows to customize a bunch
of the sdma init / sram mapping ...
- All the other code (task helpers / the .h / the driver api) would be
exactly
the same.
- Currently the task support code (the arch/ppc/syslib/fec.c for example in
the current code) does this :

        struct sdma_task *tsk;

        tsk = sdma_task_alloc(queue_len, sizeof(struct sdma_fec_bd));
        if (!tsk)
                return NULL;

To reuse the preloaded task, it would be changed to

    tsk = sdma_task_find_by_name("fec", 0);
    if (!tsk)
        tsk = sdma_task_alloc("fec", 0, queue_len, sizeof(struct
sdma_fec_bd));
    if (!tsk)
        return NULL;

So the bestcomm modules maintain a list with all task loaded with a name and
a index attribute. (The index would be used when there is multiple
device with
the same name, like "psc". We could use names like "psc1", "psc2". But that
would imply string manipulation to "create" the name string ;)

In the case of the "classic" (kernel handles it all), the table of task
is just
initially empty. But for the "custom" case, it's filled with whatever
the fw has
passed as infos.



        Sylvain
