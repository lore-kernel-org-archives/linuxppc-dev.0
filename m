Date: Wed, 10 Feb 1999 21:33:54 -0600 (CST)
From: Ken Roberts <ken@worldnet.att.net>
Reply-To: Ken Roberts <ken.r@worldnet.att.net>
To: martine@rzuni1.fh-bingen.de
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: anonftp...???
In-Reply-To: <Pine.LNX.3.96.990210142642.1001A-100000@rzuni1.fh-bingen.de>
Message-ID: <Pine.LNX.3.96.990210211811.447A-100000@dancer.at.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



do you mean without rebooting your machine?

if i understand you correctly, you have not changed any configuration files, but
instead have killed the anonymous ftp server.

i think, if inetd is running your anonymous ftp, then you should be able to do
this:

kill -HUP `cat /var/run/inetd.pid`

BEFORE YOU DO THIS:
when you send a HUP (hangup) to a unix daemon, it re-reads the configuration
file.  this is the least-destructive way to do this, it should cause all your
servers to re-read their configs without breaking critical connections to users.

also, the quotes in the line above are backticks, which is under the ~ key.  if
you can't get that to work, then you can break the command into two parts:

cat /var/run/inetd.pid

<number is printed>

kill -HUP <number>


>hello...
>
>what is to do, if i ftpshut the anonymous ftp-server and want to restart
>it?
>
>mart


-------------------------------------------------------------------------------
    Ken Roberts                                      ken.r@worldnet.att.net
                 Oft-times thou feelest like unto a nut,
                     And yet, M'lord, anon, feel'st thou not so.
                 Yon Almond Joy these selfsame nuts doth have,
                     Whereas contrary Mounds doth have them not.
                                 -- William Shakespeare, kind of


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
