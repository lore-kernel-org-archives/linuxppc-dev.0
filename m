Return-Path: <dirk.brandewie@gmail.com>
Message-ID: <4CE3770E.70506@gmail.com>
Date: Tue, 16 Nov 2010 22:32:46 -0800
From: Dirk Brandewie <dirk.brandewie@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/5] of/powerpc: Move build to use generic dts->dtb rule
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
	<dae91d8292876db96f96896b79076c32cd2bf467.1289943240.git.dirk.brandewie@gmail.com>
	<20101117060653.GI12813@angua.secretlab.ca>
In-Reply-To: <20101117060653.GI12813@angua.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	arjan@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2010 10:06 PM, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 02:41:39PM -0800, dirk.brandewie@gmail.com wrote:
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> This patch changes arch/powerpc/boot/Makefile to use the generic
>> rule build the device tree blobs in scripts/Makefile.lib
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>> ---
>>   arch/powerpc/boot/Makefile |    7 -------
>>   1 files changed, 0 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index fae8192..d90c674 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -147,8 +147,6 @@ targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
>>   extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
>>   		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
>>
>> -dtstree		:= $(srctree)/$(src)/dts
>> -
>>   wrapper		:=$(srctree)/$(src)/wrapper
>>   wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
>>   			$(wrapper) FORCE
>> @@ -331,11 +329,6 @@ $(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>>   $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>>   	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
>>
>> -# Rule to build device tree blobs
>> -DTC = $(objtree)/scripts/dtc/dtc
>> -
>> -$(obj)/%.dtb: $(dtstree)/%.dts
>> -	$(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts
> 
> This patch needs to modify the rules that have %.dtb dependencies to
> go looking in arch/powerpc/boot/dts instead of arch/powerpc/boot
> because the rule change will change where .dtb files get generated.

The rule in patch 1 takes of this. The dts directory is relative to the
arch/powerpc/boot/Makefile
+quiet_cmd_dtc = DTC	$@
+      cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(src)/dts/$*.dts
+

> 
> Also, this patch and patch 5 need to be merged with patch 1 so that
> the series remains bisectable.

I tested building a powerpc image with patch 1 applied and patch 4 unapplied and 
the image built without errors and the dtb was present in the wrapped image.
unfortunately I don't have a system to do runtime testing.
I could not build the uboot image type I am missing mkimage.  I did build
the dtbImage, zImage and cuImage types before and after this patch was applied.

--Dirk
> 
> g.
> 
>>
>>   # If there isn't a platform selected then just strip the vmlinux.
>>   ifeq (,$(image-y))
>> -- 
>> 1.7.2.3
>>
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
