Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id DBEAADDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 20:05:27 +1100 (EST)
Message-ID: <47BE8929.3050805@semihalf.com>
Date: Fri, 22 Feb 2008 09:34:49 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add support for binary includes.
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
In-Reply-To: <fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Feb 20, 2008 at 12:19 PM, Scott Wood <scottwood@freescale.com> wrote:
>> A property's data can be populated with a file's contents
>>  as follows:
>>
>>  node {
>>         prop = /incbin/("path/to/data");
>>  };
>>
>>  A subset of a file can be included by passing start and size parameters.
>>  For example, to include bytes 8 through 23:
>>
>>  node {
>>         prop = /incbin/("path/to/data", 8, 16);
>>  };
> 
> 
> Can I ask; what is the intended usage of such a thing?  How large
> would a typical binary blob be?

Binary includes are a critical feature of the new image format for
U-Boot. In short: we're describing image's content and other data
(architecture, os, image type, etc) in dts format, and then use dtc to
generate the file that is transferred to the target and booted by
U-Boot. Excerpt from an actual file describing an image:

/{
         images {
                 kernel@1 {
                         data = /incbin/("./vmlinux.bin.gz");
                         type = "kernel";
                         arch = "ppc";
                         os = "linux";
                         compression = "gzip";
                         load = <00000000>;
                         entry = <00000000>;
                 };
         };
};

As to the size of the final blob in our case, it depends. It seems that
in case of a powerpc Linux booting scenario, most of the times the size
will be roughly the size of a compressed kernel + the size of the FDT
blob, eventually plus the size of a ramdisk. Note however, that the new
image format has provisions for handling multiple components of the same
type in one image, so for example you could have three kernels, two
ramdisks and a couple of fdt blobs in one image, and the actual booting
configuration could be selected in U-Boot. In such a case, the final
blob can be arbitrarily large.

Regards,
Bartlomiej
