Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9QQf3JhwzDt1M
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 02:16:10 +1100 (AEDT)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Baoquan He <bhe@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
Date: Fri, 04 Nov 2016 10:13:39 -0500
In-Reply-To: <20161104073840.GD4314@x1> (Baoquan He's message of "Fri, 4 Nov
 2016 15:38:40 +0800")
Message-ID: <871syrcm70.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Baoquan He <bhe@redhat.com> writes:

> On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
>> Hello,
>> 
>> The kexec_file code currently builds the purgatory as a partially linked object 
>> (using ld -r). Is there a particular reason to use that instead of a position 
>> independent executable (PIE)?
>
> It's taken as "-r", relocatable in user space kexec-tools too originally.
> I think Vivek just keeps it the same when moving into kernel.

At least on x86 using just -r removed the need for a GOT and all of the
other nasty dynamic relocatable bits, that are not needed when the you
don't want to share your text bits with the page cache.

I can see reaons for refactoring code but I expect PIE expecutables need
a GOT and all of that pain in the neck stuff that can just be avoided by
building the code to run at an absolute address.

So far I have not seen ELF relocations that are difficult to process.

Eric
