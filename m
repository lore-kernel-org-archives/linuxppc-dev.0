Return-Path: <linas@austin.ibm.com>
Date: Mon, 19 Nov 2007 11:51:44 -0600
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: hangs after "Freeing unused kernel memory"
Message-ID: <20071119175144.GD4670@austin.ibm.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 15, 2007 at 04:00:09PM -0800, Siva Prasad wrote:
> Hi,
> 
> This sounds like a familiar problem, but could not get answers in posts
> that came up in google search.
> 
> My system hangs after printing the message "Freeing unused kernel
> memory". It should execute init after that, but not sure what exactly is
> happening. Appreciate if some one can throw few ideas to try out.

It might not be a hang, it might be simply that you loose the console.
If this is a redhat system, and you didn't tweak initrd and udev just 
right, this can happen.

Try doing this:

      mount --bind / /mnt
      cp -a /dev/null /mnt/dev
      cp -a /dev/console /mnt/dev
      cp -a /dev/hv* /mnt/dev
      umount /mnt

> Seems it is actually hanging when it makes the call "
> run_init_process(ramdisk_execute_command)" in init/main.c

Then again, your initrd might be corrupted.

--linas
