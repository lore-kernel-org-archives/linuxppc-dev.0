Subject: Re: mvista 2.0 cdk and login username and password
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFC00EF5EC.1C13B6AA-ON85256AFC.006E1C01@raleigh.ibm.com>
From: "John F Davis" <johndavi@us.ibm.com>
Date: Tue, 6 Nov 2001 16:15:25 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Mark,

I don't have a /etc/passwd file.  Thus I can't login.  I didn't use the
install script.  I just installed the rpm's by hand
like we did in cdk 1.2. i.e rpm -ivh --ignorearch *.rpm.  I didnt want to
use the script because I didn't use the
cdrom.  I had a copy of the cdrom filesystem mounted via AFS.  The script
seems to think it is only used via a cdrom or mountable media.
I figured it would be easier to just install all the rpm's rather than try
to patch your script.  I already have problems installing
both a 405 CDK and 750 CDK on the same machine.  I get errors about rpm
conflicts with common files.  My coworker says mvista has
released a patch for this, but I haven't tried using it yet.

I will try to reinstall the passwd package again by hand.  However, I don't
see how installing the rpm manualy would cause
it not to create the /etc/passwd file.  I also don't understand why the rpm
which creates the files doesnt register with the rpm database
that it owns the file.  ie. 'rpm -q -f
/opt/hardhat/devkit/ppc/7xx/target/etc/passwd' comes up blank.

Also, I didnt see anything in the install script which would make a
etc/passwd file so it must be as you said below.  The file is
created via a rpm.

I got my hhzone password now.  I look forward to seeing what's up there.

Thanks to you and the rest of the mvista team for the quick response.  I
dont consider the issue closed yet, but
I do appreciate your help so far.

John

Mark Hatle <fray@mvista.com>@mvista.com on 11/05/2001 05:44:46 PM

Sent by:  fray@mvista.com


To:   John F Davis/Raleigh/IBM@ibmus
cc:   linuxppc-embedded@lists.linuxppc.org, support@mvista.com
Subject:  Re: mvista 2.0 cdk and login username and password



John F Davis wrote:
>
> Hello
>
> What's the root login password for a newly installed sbs-k2, cdk 2.0,
> target login?  The final paragraph of the sbs-k2
> installation section (in the pdf) says to login, but doesn't specify a
> password for root.

There is no root password by default.  Normally you type root and you
are logged in.. (Security hole?  for a desktop/workstation distro yes,
but not for an embedded distro!)

> I installed the cd and when I try to login to a nfs root mounted
partition,
> I get a login prompt, but I can't login.
> My installation doesn't   have a /..../target/etc/passwd file, which
leads
> me to believe I missed something during
> the install.  However, I searched the CD for rpm's and none of them
> owns/supplies  the /.../target/etc/passwd file.
> Am I supposed to modify the inittab on the host machine so it boots
single
> user mode and create the /etc/password
> file by hand, modify the inittab for multiuser mode and then reboot?

Sounds like the install did not work.  (Did you use the installer?)  The
"base-passwd" package controls the password files.  It installs a
passwd/group template into (target filesystem) /usr/share/base-passwd
and then proceeds to copy them over into /etc/passwd,group.  This is
done in case you already have an /etc/passwd,group so that it will not
be over written, but "upgraded".

> Also, when am I going to get a hardhat zone login id?  I am sure MVista
has
> a FAQ which addresses this issue.

If you are a paying customer, contact your support representative, and
not the linuxppc-embedded list as they have nothing to do with our
product.

Mark Hatle
MontaVista Software, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
