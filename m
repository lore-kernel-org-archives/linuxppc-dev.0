To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Password on ELDK nfs booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Aug 2002 17:17:27 +0900."
             <007601c24da2$2f0e4420$1a11efcb@industrialDiv.hanasys.co.kr>
Date: Tue, 27 Aug 2002 15:24:54 +0200
Message-Id: <20020827132459.6F0741182F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <007601c24da2$2f0e4420$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
>
> I booted on nfs mounted ELDK.
> I changed root password, rebooted and enter the password.
> But the password did not entered.
> I got Login timed out message after 60 second.

You must have done something wrong; setting, modifying  and  deleting
passwords works fine here:

bash-2.04# cat /etc/passwd
root::0:0:root:/root:/bin/bash
bin:*:1:1:bin:/bin:
...
bash-2.04# passwd
New UNIX password:
Retype new UNIX password:
passwd: all authentication tokens updated successfully
bash-2.04# cat /etc/passwd
root:$1$kVReOwuM$hoM6p0uK11zbUAFP378O/1:0:0:root:/root:/bin/bash
bin:*:1:1:bin:/bin:
...
bash-2.04# exit
logout

pm826 login: root
Password:
Last login: Tue Aug 27 15:21:01 on console
bash-2.04# passwd -d root
Changing password for user root
Removing password for user root
passwd: Success
bash-2.04# cat /etc/passwd
root::0:0:root:/root:/bin/bash
bin:*:1:1:bin:/bin:
...


> eva login: root
> Password: Login timed out after 60 seconds
> tts/0: 1 input overrun(s)
> d

It seems you are using devfs; try running without  it.  I  don't  see
much   advantages   of  devfs  for  embedded  systems  where  such  a
flexibility is usually not needed, on contrary.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The algorithm to do that is extremely nasty. You might want  to  mug
someone with it."                   - M. Devine, Computer Science 340

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
