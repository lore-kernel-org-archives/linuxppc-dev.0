Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 66454B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 21:30:50 +1000 (EST)
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2862FDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 21:30:46 +1000 (EST)
Message-ID: <4A684A03.5010803@gefanuc.com>
Date: Thu, 23 Jul 2009 12:31:15 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Mechanism to enable use Generic NVRAM driver for
	different size chips
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>	
	<20090702161224.31202.65236.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<1248334988.3367.77.camel@pasglop>
In-Reply-To: <1248334988.3367.77.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2009-07-02 at 17:12 +0100, Martyn Welch wrote:
>   
>> Remove the reliance on a staticly defined NVRAM size, allowing platforms to support NVRAMs with sizes differing from the standard. A fall back value is provided for platforms not supporting this extension.
>>
>> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
>>     
>
> What about other archs that use this driver ? They would also need
> that new nvram_size() ...
>   
I'm fairly confident that this driver is solely used by the PowerPC 
architecture. The config option being set in  arch/powerpc/Kconfig[1]. 
Other than the obvious matches in drivers/char/Makefile[2] and powerpc 
defconfigs, the only other places I can find the option being used are:

* As a requirement for CONFIG_NVRAM on the PowerPC platform in 
drivers/char/Kconfig[3]
* In "include/config/auto.conf" and "include/linux/autoconf.h". Are 
these for generation of generic configs?

Martyn

[1] 
http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/benh/powerpc.git;a=blob;f=arch/powerpc/Kconfig#l145
[2] 
http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/benh/powerpc.git;a=blob;f=drivers/char/Makefile#l83
[3] 
http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/benh/powerpc.git;a=blob;f=drivers/char/Kconfig#l777
> BTW. This patch touches non-arch code so should at least be CCed to lkml
>
> Cheers,
> Ben.
>
>   
>> ---
>>
>>  arch/powerpc/include/asm/nvram.h |    3 +++
>>  arch/powerpc/kernel/setup_32.c   |    8 ++++++++
>>  drivers/char/generic_nvram.c     |   27 ++++++++++++++++++++-------
>>  3 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
>> index efde5ac..71df8b2 100644
>> --- a/arch/powerpc/include/asm/nvram.h
>> +++ b/arch/powerpc/include/asm/nvram.h
>> @@ -107,6 +107,9 @@ extern void	pmac_xpram_write(int xpaddr, u8 data);
>>  /* Synchronize NVRAM */
>>  extern void	nvram_sync(void);
>>  
>> +/* Determine NVRAM size */
>> +extern ssize_t nvram_size(void);
>> +
>>  /* Normal access to NVRAM */
>>  extern unsigned char nvram_read_byte(int i);
>>  extern void nvram_write_byte(unsigned char c, int i);
>> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
>> index 1d15424..28f7570 100644
>> --- a/arch/powerpc/kernel/setup_32.c
>> +++ b/arch/powerpc/kernel/setup_32.c
>> @@ -208,6 +208,14 @@ void nvram_write_byte(unsigned char val, int addr)
>>  }
>>  EXPORT_SYMBOL(nvram_write_byte);
>>  
>> +ssize_t nvram_size(void)
>> +{
>> +	if (ppc_md.nvram_size)
>> +		return ppc_md.nvram_size();
>> +	return -1;
>> +}
>> +EXPORT_SYMBOL(nvram_size);
>> +
>>  void nvram_sync(void)
>>  {
>>  	if (ppc_md.nvram_sync)
>> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
>> index a00869c..e5f71f3 100644
>> --- a/drivers/char/generic_nvram.c
>> +++ b/drivers/char/generic_nvram.c
>> @@ -2,7 +2,7 @@
>>   * Generic /dev/nvram driver for architectures providing some
>>   * "generic" hooks, that is :
>>   *
>> - * nvram_read_byte, nvram_write_byte, nvram_sync
>> + * nvram_read_byte, nvram_write_byte, nvram_sync, nvram_size
>>   *
>>   * Note that an additional hook is supported for PowerMac only
>>   * for getting the nvram "partition" informations
>> @@ -28,6 +28,8 @@
>>  
>>  #define NVRAM_SIZE	8192
>>  
>> +static ssize_t nvram_len;
>> +
>>  static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
>>  {
>>  	lock_kernel();
>> @@ -36,7 +38,7 @@ static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
>>  		offset += file->f_pos;
>>  		break;
>>  	case 2:
>> -		offset += NVRAM_SIZE;
>> +		offset += nvram_len;
>>  		break;
>>  	}
>>  	if (offset < 0) {
>> @@ -56,9 +58,9 @@ static ssize_t read_nvram(struct file *file, char __user *buf,
>>  
>>  	if (!access_ok(VERIFY_WRITE, buf, count))
>>  		return -EFAULT;
>> -	if (*ppos >= NVRAM_SIZE)
>> +	if (*ppos >= nvram_len)
>>  		return 0;
>> -	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count)
>> +	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
>>  		if (__put_user(nvram_read_byte(i), p))
>>  			return -EFAULT;
>>  	*ppos = i;
>> @@ -74,9 +76,9 @@ static ssize_t write_nvram(struct file *file, const char __user *buf,
>>  
>>  	if (!access_ok(VERIFY_READ, buf, count))
>>  		return -EFAULT;
>> -	if (*ppos >= NVRAM_SIZE)
>> +	if (*ppos >= nvram_len)
>>  		return 0;
>> -	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count) {
>> +	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
>>  		if (__get_user(c, p))
>>  			return -EFAULT;
>>  		nvram_write_byte(c, i);
>> @@ -133,9 +135,20 @@ static struct miscdevice nvram_dev = {
>>  
>>  int __init nvram_init(void)
>>  {
>> +	int ret = 0;
>> +
>>  	printk(KERN_INFO "Generic non-volatile memory driver v%s\n",
>>  		NVRAM_VERSION);
>> -	return misc_register(&nvram_dev);
>> +	ret = misc_register(&nvram_dev);
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	nvram_len = nvram_size();
>> +	if (nvram_len < 0)
>> +		nvram_len = NVRAM_SIZE;
>> +
>> +out:
>> +	return ret;
>>  }
>>  
>>  void __exit nvram_cleanup(void)
>>     
>
>   


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
