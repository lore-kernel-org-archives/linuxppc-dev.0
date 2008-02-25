Return-Path: <jirislaby@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id C8415DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 19:16:58 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so955849fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 00:16:56 -0800 (PST)
Message-ID: <47C2796F.2070601@gmail.com>
Date: Mon, 25 Feb 2008 09:16:47 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Xilinx: hwicap: cleanup
References: <1202437061-12691-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080211182429.76E204D8018@mail62-sin.bigfish.com>
	<fa686aa40802232216s47b7751bi384352697dbf4ce2@mail.gmail.com>
	<20080224232152.CEC5F12C8057@mail99-dub.bigfish.com>
In-Reply-To: <20080224232152.CEC5F12C8057@mail99-dub.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/25/2008 12:21 AM, Stephen Neuendorffer wrote:
>>>  @@ -549,8 +556,7 @@ static int hwicap_release(struct inode *inode,
> struct file *file)
>>>         int i;
>>>         int status = 0;
>>>
>>>  -       if (down_interruptible(&drvdata->sem))
>>>  -               return -ERESTARTSYS;
>>>  +       mutex_lock(&drvdata->sem);
>> Why not mutex_lock_interruptible()? (goes for all cases of
> mutex_lock())
> 
> It's not clear to me how to get 'correct' behavior in these functions if
> the interrupt happens.  For instance in probe/setup, if the mutex_lock
> is interrupted, it doesn't appear that there is anything to do other
> than return an error code that no device is present?  I think this was
> suggested by Jiri...

Yeah, since ERESTARTSYS would be ignored from f_op->release (see __fput()), 
drv->probe (see really_probe() and probe_failed label); not even talking about 
void return value functions. In those cases, the device won't be de/initialized 
and might result in unwanted behaviour (multiple modprobes for one device, 
rmmod/insmod need if you hit the path in release etc.).
