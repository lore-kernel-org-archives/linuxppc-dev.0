Cc: "'linuxppc-embedded@lists.linuxppc.org'"
    <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <39D24EE1.10964CA@lucent.com>
Date: Wed, 27 Sep 2000 14:47:45 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
Subject: Re: printk() ?
References: <67505026E29DD311A9AA00508B7315F350A527@EXCHANGE> <39D0F6DC.4DDB7509@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhaobin Zhu wrote:
> Where does printk() in linux kernel send message to ?

It normally prints to the syslogd facility, which by default makes it come
out in the file /var/log/messages and also for important enough messages
comes out on the console. Note that if you write your own console driver,
you probably need to write _two_ drivers: the actual console driver used
by printk (the read routine seems to be unused), and a serial I/O driver
which will be opened by the kernel for the init process. Console drivers
themselves do not appear in the filesystem, but are registered via
register_console(). The serial I/O device needs to appear in the filesystem
for the kernel to open it for init, so should be a standard char device.


> In which file I can find it ?

kernel/printk.c


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
