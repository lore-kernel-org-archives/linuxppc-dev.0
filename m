Date: Mon, 1 Dec 2003 14:47:31 +0100 (MET)
From: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
Subject: Re: mpc / linux kernel - user space
In-Reply-To: <1070266735.328.5.camel@linpc003.aimsys.nl>
Message-ID: <Pine.GHP.4.58.0312011432180.23681@stud3.tuwien.ac.at>
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>
 <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>
 <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>
 <1070011018.1263.27.camel@linpc003.aimsys.nl>  <3FC76CEA.9040309@embeddededge.com>
 <1070266735.328.5.camel@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I tried to make use of wake_up_interruptible(wq) in my module as
following (I just wanted to test if I'm using it correctly):
If I'm doing insmod, the module blocks in the wake_up_interruptible call.
Does somebody know why? Maybe because there is no process sleeping? How do
I check this?

DECLARE_WAIT_QUEUE_HEAD(wq);

int sleepy_init(void) {
  test_file = create_proc_entry("test", 0666, NULL);
  if(test_file == NULL) {
    return -ENOMEM;
  }

  wake_up_interruptible(&wq);

  return 0;
}

void sleepy_cleanup(void) {
remove_proc_entry("test", NULL);
}

module_init(test_init);
module_exit(test_cleanup);


Best regards,
Juergen

On Fri, 2003-11-28 at 10:21, Aain_Devarenne%ZODIAC@zodiac.com wrote:
> Hi everybody
>
> I 'm pending on the same problem as Juergen,
> - How can a User Space Thread Wait for a signaling event set by KERNEL ?

e.g. issue a read on some device driver (/dev/<your driver>
which will block until an interrupt has occured.
something like this:

DECLARE_WAIT_QUEUE_HEAD(mydriver_queue);

ssize_t mydriver_read(
struct file *filp,
char *buf,
size_t count,
loff_t *f_pos)
{
/* wait on interrupt */
while (1) {
interruptible_sleep_on(&mydriver_queue);
if (signal_pending (current)) /* a signal arrived */
return -ERESTARTSYS; /* tell the fs layer to handle it */
else break;
}
return 0;
}

void mydriver_irqhandler(unsigned long arg)
{
wake_up_interruptible(&mydriver_queue);
}

Jaap-Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
